//
//  AddInnView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct AddInnView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var number: String = ""
    @State private var name: String = ""
    @State private var dateOfBirth: String = ""
    @State private var placeOfBirth: String = ""
    @State private var selectedGender: Sex = .none

    @State private var genders: [Sex] = [.female, .male]

    var body: some View {
        VStack {
            CardView()
            Spacer(minLength: 0)
            Button(action: {
                   saveData()
                presentationMode.wrappedValue.dismiss()
            }) {
                Label("Добавить ИНН", systemImage: "lock.circle.fill")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.linearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
            }
            .disableWithOpacity(number.count != 14 || name.isEmpty || dateOfBirth.count != 10 || placeOfBirth.isEmpty || selectedGender == .none)
        }
        .padding()
    }
    @ViewBuilder
    func CardView() -> some View {
        VStack() {
            Text("СВИДЕТЕЛЬСТВО").font(.caption).foregroundColor(.innFontTop).padding(.top, 10)
            Text("О ПОСТАНОВКЕ НА УЧЕТ В НАЛОГОВОМ ОРГАНЕ").font(.caption2).foregroundColor(.innFontTop)
            VStack() {
                HStack {
                    VStack {
                        /// Номер ИНН
                        HStack {
                            Text("Номер")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        HStack {
                            TextField("XXXX XXXX XXXX", text: $number)
                                .onChange(of: number, { oldValue, newValue in
                                    number = ""
                                    let startIndex = oldValue.startIndex
                                    for index in 0..<oldValue.count {
                                        let stringIndex = oldValue.index(startIndex, offsetBy: index)
                                        number += String(oldValue[stringIndex])

                                        if (index + 1) % 5 == 0 && oldValue[stringIndex] != " " {
                                            number.insert(" ", at: stringIndex)
                                        }
                                    }
                                    if oldValue.last == " " {
                                        number.removeLast()
                                    }
                                    number = String(number.prefix(14))
                                })
                                .font(.title3)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        /// ФИО
                        HStack {
                            Text("ФИО")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.top, 10)
                        HStack {
                            TextField("XXXXXX XXXXXX XXXXXX", text: $name)
                                .onChange(of: name, { oldValue, newValue in
                                    name = oldValue.uppercased()
                                })
                                .multilineTextAlignment(.leading)
                        }
                        /// Дата рождения
                        HStack {
                            Text("Дата рождения")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.top, 10)
                        HStack {
                            TextField("XX.XX.XXXX", text: $dateOfBirth)
                                .onChange(of: dateOfBirth, { oldValue, newValue in
                                    dateOfBirth = oldValue.replacingOccurrences(of: ".", with: "")
                                    let nonDecimalCharacters = CharacterSet.decimalDigits.inverted
                                    let updatedTextWithoutDots = dateOfBirth.components(separatedBy: nonDecimalCharacters).joined()

                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "ddMMyyyy"
                                    var formattedDate = ""
                                    var index = 0

                                    for character in updatedTextWithoutDots {
                                        if index == 2 || index == 4 {
                                            formattedDate.append(".")
                                        }

                                        formattedDate.append(character)
                                        index += 1
                                    }
                                    dateOfBirth = formattedDate
                                    dateOfBirth = String(dateOfBirth.prefix(10))
                                })
                                .multilineTextAlignment(.leading)
                                .keyboardType(.numberPad)
                            Spacer()
                        }
                        /// Пол
                        HStack {
                            Text("Пол")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("Место рождения")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }.padding(.top, 10)
                        HStack {
                            Menu {
                                ForEach(genders, id: \.self) { gender in
                                    Button(action: { selectedGender = gender
                                    }) {
                                        Text(gender.rawValue).tag(gender)
                                    }
                                }
                            } label: {
                                Text(selectedGender.rawValue)
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                                    .underline()
                            }
                            Spacer()
                            TextField("XXXXXXXXX", text: $placeOfBirth)
                                .onChange(of: placeOfBirth, { oldValue, newValue in
                                    placeOfBirth = oldValue.uppercased()
                                })
                                .multilineTextAlignment(.trailing)
                        }
                    }.padding(20)
                        Image(.herbInn)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .tint(.innFontInside)
                }
                .padding(.top, 10)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.innInside)
                }
            }
        }
        .environment(\.colorScheme, .light)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.innTop)
        }
    }
    
    private func saveData() {
        let inn = INNModel(number: number, name: name, gender: selectedGender, dateOfBirth: dateOfBirth, placeOfBirth: placeOfBirth)
        modelContext.insert(inn)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    AddInnView()
}
