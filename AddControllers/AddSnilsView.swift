//
//  AddSnilsView.swift
//  Fox Docs
//
//  Created by Fox on 13.02.2024.
//

import SwiftUI

struct AddSnilsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var number: String = ""
    @State private var name: String = ""
    @State private var dateAndPlace: String = ""
    @State private var selectedSex: Sex = .none
    @State private var sex: [Sex] = [.female, .male]
    @State private var selectedDoc: TypeOfDocs = .snils


    var body: some View {
        VStack {
            CardView()
            Spacer(minLength: 0)
            Button(action: {
                   saveData()
                presentationMode.wrappedValue.dismiss()
            }) {
                Label("Добавить СНИЛС", systemImage: "lock.circle.fill")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.linearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
            }
            .disableWithOpacity(number.count != 14 || name.isEmpty || dateAndPlace.isEmpty || selectedSex == .none)
        }
        .padding()
    }

    @ViewBuilder
    func CardView() -> some View {
        VStack() {
            Text("СТРАХОВОЕ СВИДЕТЕЛЬСТВО").font(.caption).foregroundColor(.snilsTop).padding(.top, 10)
            Text("ОБЯЗАТЕЛЬНОГО ПЕНСИОННОГО СТРАХОВАНИЯ").font(.caption2).foregroundColor(.snilsTop)
            VStack() {
                VStack {
                    HStack {
                        Text("Номер")
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    TextField("XXX-XXX-XXX XX", text: $number)
                        .onChange(of: number, { oldValue, newValue in
                            let formattedText = oldValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                            var finalText = ""
                            var index = 0
                            for character in formattedText {
                                if index == 3 || index == 6 {
                                    finalText += "-"
                                }
                                if index == 9 {
                                    finalText += " "
                                }
                                finalText.append(character)
                                index += 1
                            }
                            if finalText.count > 14 {
                                finalText = String(finalText.prefix(14))
                            }
                            number = finalText
                        })
                        .keyboardType(.numberPad)
                    HStack {
                        Text("ФИО")
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }.padding(.top, 10)
                    TextField("КОТИНА ДАРЬЯ СЕРГЕЕВНА", text: $name)
                        .onChange(of: name, { oldValue, newValue in
                            name = oldValue.uppercased()
                        })
                    HStack {
                        Text("Дата и место рождения")
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }.padding(.top, 10)
                    TextField("02 АПРЕЛЯ 1997 ГОДА МОСКВА", text: $dateAndPlace)
                        .onChange(of: dateAndPlace, { oldValue, newValue in
                            dateAndPlace = oldValue.uppercased()
                        })
                    HStack {
                        Text("Пол")
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }.padding(.top, 10)
                    HStack {
                        Menu {
                            ForEach(sex, id: \.self) { sex in
                                Button(action: { selectedSex = sex
                                }) {
                                    Text(sex.rawValue).tag(sex)
                                }
                            }
                        } label: {
                            Text(selectedSex.rawValue)
                                .font(.callout)
                                .foregroundColor(.secondary)
                                .underline()
                        }
                        Spacer()
                    }
                }.padding(20)
            }
            .padding(.top, 10)
            .environment(\.colorScheme, .light)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.snils)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.snilsHead)
        }
    }

    private func saveData() {
        let snils = SnilsModel(number: number, name: name, dateAndPlace: dateAndPlace, sex: selectedSex, type: selectedDoc.rawValue)
        modelContext.insert(snils)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    AddSnilsView()
}
