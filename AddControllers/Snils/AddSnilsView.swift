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
            AddButtonView(saveAction: saveData, presentationMode: presentationMode)
                .disableWithOpacity(number.count != 14 || name.isEmpty || dateAndPlace.isEmpty || selectedSex == .none)
        }
        .padding()
    }

    func TitleView(_ title: String) -> some View {
        VStack {
            HStack {
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.black)
                Spacer()
            }
        }
    }

    func MainTitleView() -> some View {
        VStack {
            Text("СТРАХОВОЕ СВИДЕТЕЛЬСТВО").font(.caption).foregroundColor(.snilsTop).padding(.top, 10)
            Text("ОБЯЗАТЕЛЬНОГО ПЕНСИОННОГО СТРАХОВАНИЯ").font(.caption2).foregroundColor(.snilsTop)
        }
    }

    @ViewBuilder
    func CardView() -> some View {
        VStack() {
            MainTitleView()
            VStack() {
                VStack {
                    TitleView("Номер")
                    TextField("XXX-XXX-XXX XX", text: $number)
                        .onChange(of: number, { oldValue, newValue in
                            number = formatNumber(oldValue)
                        })
                        .keyboardType(.numberPad)
                    TitleView("ФИО").padding(.top, 10)
                    TextField("КОТИНА ДАРЬЯ СЕРГЕЕВНА", text: $name)
                        .onChange(of: name, { oldValue, newValue in
                            name = oldValue.uppercased()
                        })
                    TitleView("Дата и место рождения").padding(.top, 10)
                    TextField("02 АПРЕЛЯ 1997 ГОДА МОСКВА", text: $dateAndPlace)
                        .onChange(of: dateAndPlace, { oldValue, newValue in
                            dateAndPlace = oldValue.uppercased()
                        })
                    TitleView("Пол").padding(.top, 10)
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

    private func formatNumber(_ value: String) -> String {
        let cleanValue = value.replacingOccurrences(of: "-", with: "")
        let formattedValue = cleanValue.chunkFormatted(withChunkSize: 3, withSeparator: "-")
        return String(formattedValue.prefix(14))
    }
}

#Preview {
    AddSnilsView()
}

