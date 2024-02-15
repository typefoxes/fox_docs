//
//  AddIntPassportView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct AddIntPassportView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var surname: String = ""
    @State private var surnameEng: String = ""
    @State private var givenName: String = ""
    @State private var givenNameEng: String = ""
    @State private var dateOfBirth: String = ""
    @State private var selectedGender: Gender = .none
    @State private var gender: [Gender] = [.f, .m]
    @State private var placeOfBirth: String = ""
    @State private var placeOfBirthEng: String = ""
    @State private var dateOfIssue: String = ""
    @State private var dateOfexpire: String = ""
    @State private var authority: String = ""
    @State private var number: String = ""
    @State private var selectedDoc: TypeOfDocs = .passportInt

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
            .disableWithOpacity(number.count != 10 || surname.isEmpty || surnameEng.isEmpty || selectedGender == .none || givenName.isEmpty || givenNameEng.isEmpty || dateOfBirth.count != 10 || placeOfBirth.isEmpty || placeOfBirthEng.isEmpty || dateOfexpire.count != 10 || authority.isEmpty || dateOfIssue.count != 10)
        }
        .padding()
    }

    @ViewBuilder
    func CardView() -> some View {
        VStack {
            Text("РОССИЙСКАЯ ФЕДЕРАЦИЯ / RUSSIAN FEDERATION")
                .font(.caption)
                .foregroundColor(.passportText)
            VStack {
                    HStack {
                        Image(.passportPhoto)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 130)
                            .cornerRadius(10)
                        VStack(spacing: 0) {
                            /// Фамилия / Surname
                            HStack {
                                Text("Фамилия")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                                Text("/")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                                Text("Surname")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                            }
                            HStack {
                                TextField("Добровольская", text: $surname)
                                    .font(.caption2)
                                    .onChange(of: surname, { oldValue, newValue in
                                        surname = oldValue.uppercased()
                                    })
                                    .foregroundColor(.secondary)
                                TextField("Dobrovolskaya", text: $surnameEng)
                                    .font(.caption2)
                                    .multilineTextAlignment(.trailing)
                                    .onChange(of: surnameEng, { oldValue, newValue in
                                        surnameEng = oldValue.uppercased()
                                    })
                                    .foregroundColor(.secondary)
                            }
                            /// Имя / Given name
                            HStack {
                                Text("Имя")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                                Text("/")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                                Text("Given name")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                            }.padding(.top, 5)
                            HStack {
                                TextField("Елена Александровна", text: $givenName)
                                    .font(.caption2)
                                    .onChange(of: givenName, { oldValue, newValue in
                                        givenName = oldValue.uppercased()
                                    })
                                TextField("Elena", text: $givenNameEng)
                                    .font(.caption2)
                                    .multilineTextAlignment(.trailing)
                                    .onChange(of: givenNameEng, { oldValue, newValue in
                                        givenNameEng = oldValue.uppercased()
                                    })
                            }
                            /// Дата рождения / Date of birth
                            HStack {
                                Text("Дата рождения / Date of birth")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                            }.padding(.top, 5)
                            HStack {
                                TextField("02.04.1997", text: $dateOfBirth)
                                    .font(.caption2)
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
                                    .keyboardType(.numberPad)
                            }
                            /// Пол/ Sex
                            HStack {
                                Text("Пол / Sex")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                            }.padding(.top, 5)
                            HStack {
                                Menu {
                                    ForEach(gender, id: \.self) { gender in
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
                            }
                            /// Место рождения / Place of birth
                            HStack {
                                Text("Место рождения")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                                Text("/")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                                Text("Place of birth")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                            }.padding(.top, 5)
                            HStack {
                                TextField("Г.МОСКВА", text: $placeOfBirth)
                                    .font(.caption2)
                                    .onChange(of: placeOfBirth, { oldValue, newValue in
                                        placeOfBirth = oldValue.uppercased()
                                    })
                                TextField("RUSSIA", text: $placeOfBirthEng)
                                    .font(.caption2)
                                    .multilineTextAlignment(.trailing)
                                    .onChange(of: placeOfBirthEng, { oldValue, newValue in
                                        placeOfBirthEng = oldValue.uppercased()
                                    })
                            }

                        }
                    }
            }.padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.passportInside)
                    }            
                .environment(\.colorScheme, .light)
            HStack() {
                VStack {
                    VStack() {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
            }
            VStack {
                VStack {
                    /// Дата выдачи / Date of issue
                    HStack {
                        Text("Дата выдачи / Date of issue")
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }.padding(.top, 5)
                    HStack {
                        TextField("05.08.2019", text: $dateOfIssue)
                            .font(.caption2)
                            .onChange(of: dateOfIssue, { oldValue, newValue in
                                dateOfIssue = oldValue.replacingOccurrences(of: ".", with: "")
                                let nonDecimalCharacters = CharacterSet.decimalDigits.inverted
                                let updatedTextWithoutDots = dateOfIssue.components(separatedBy: nonDecimalCharacters).joined()

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
                                dateOfIssue = formattedDate
                                dateOfIssue = String(dateOfIssue.prefix(10))
                            })
                            .keyboardType(.numberPad)
                    }
                    /// Дата окончания срока действия / Date of expire
                    HStack {
                        Text("Дата окончания срока действия / Date of expire")
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }.padding(.top, 5)
                    HStack {
                        TextField("05.08.2024", text: $dateOfexpire)
                            .font(.caption2)
                            .onChange(of: dateOfexpire, { oldValue, newValue in
                                dateOfexpire = oldValue.replacingOccurrences(of: ".", with: "")
                                let nonDecimalCharacters = CharacterSet.decimalDigits.inverted
                                let updatedTextWithoutDots = dateOfexpire.components(separatedBy: nonDecimalCharacters).joined()

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
                                dateOfexpire = formattedDate
                                dateOfexpire = String(dateOfexpire.prefix(10))
                            })
                            .keyboardType(.numberPad)
                    }
                    /// Орган, выдавший документ / Authority
                    HStack {
                        Text("Орган, выдавший документ / Authority")
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }.padding(.top, 5)
                    HStack {
                        TextField("ФМС 77718", text: $authority)
                            .font(.caption2)
                            .onChange(of: authority, { oldValue, newValue in
                                authority = oldValue.uppercased()
                    })
                    }
                    /// Номер паспорта / Passport No.
                    HStack {
                        Text("Номер паспорта / Passport No.")
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }.padding(.top, 5)
                    HStack {
                        TextField("73 5555555", text: $number)
                            .font(.caption2)
                            .onChange(of: number, { oldValue, newValue in
                                let formattedText = oldValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                                var finalText = ""
                                var index = 0
                                for character in formattedText {
                                    if index == 2 {
                                        finalText += " "
                                    }
                                    finalText.append(character)
                                    index += 1
                                }
                                if finalText.count > 10 {
                                    finalText = String(finalText.prefix(10))
                                }
                                number = finalText

                            })
                    }
                }.padding(5)
            }
            .environment(\.colorScheme, .light)
            .padding(5)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.passportInside)
                }
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.passport)
            }
    }

    private func saveData() {
        let passport = PassportIntModel(surname: surname, surnameEng: surnameEng, givenName: givenName, givenNameEng: givenNameEng, dateOfBirth: dateOfBirth, gender: selectedGender, placeOfBirth: placeOfBirth, placeOfBirthEng: placeOfBirthEng, dateOfexpire: dateOfexpire, dateOfIssue: dateOfIssue, authority: authority, number: number, type: selectedDoc.rawValue)
        modelContext.insert(passport)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    AddIntPassportView()
}
