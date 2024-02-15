//
//  AddIntPassportView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct ShowPassportIntView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var showAlert = false

    let passport: PassportIntModel

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Загран. Паспорт")
                        .font(.title3)
                        .padding(.leading, 10)
                    Spacer()
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "trash.circle.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Вы хотите удалить этот документ?"),
                              primaryButton: .cancel(Text("Отменить")),
                              secondaryButton: .destructive(Text("Удалить")) {
                             deleteData()
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
                }
                .padding(.vertical, 20)
                CardView()
                Spacer(minLength: 0)
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Label("Закрыть", systemImage: "xmark.circle.fill")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(.linearGradient(colors: [Color.orange, Color.red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                }
            }
            .padding()
        }
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
                            Text("Фамилия / Surname")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        HStack {
                            Text("\(passport.surname) / \(passport.surnameEng)")
                                .font(.caption2)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        /// Имя / Given name
                        HStack {
                            Text("Имя / Given name")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.top, 10)
                        HStack {
                            Text("\(passport.givenName) / \(passport.givenNameEng)")
                                .font(.caption2)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        /// Дата рождения / Date of birth
                        HStack {
                            Text("Дата рождения / Date of birth")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.top, 10)
                        HStack {
                            Text(passport.dateOfBirth)
                                .font(.caption2)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        /// Пол / Sex
                        HStack {
                            Text("Пол / Sex")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.top, 10)
                        HStack {
                            Text(passport.gender.rawValue)
                                .font(.caption2)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        /// Место рождения / Place of birth
                        HStack {
                            Text("Место рождения / Place of birth")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.top, 10)
                        HStack {
                            Text("\(passport.placeOfBirth) / \(passport.placeOfBirthEng)")
                                .font(.caption2)
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                }
            }
            .padding(10)
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
            HStack {
                VStack {
                    /// Дата выдачи / Date of issue
                    HStack {
                        Text("Дата выдачи / Date of issue")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Spacer()
                    }.padding(.top, 10)
                    HStack {
                        Text(passport.dateOfIssue)
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    /// Дата окончания срока действия / Date of expire
                    HStack {
                        Text("Дата окончания срока действия / Date of expire")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Spacer()
                    }.padding(.top, 10)
                    HStack {
                        Text(passport.dateOfexpire)
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    /// Орган, выдавший документ / Authority
                    HStack {
                        Text("Орган, выдавший документ / Authority")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Spacer()
                    }.padding(.top, 10)
                    HStack {
                        Text(passport.authority)
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    /// Номер паспорта / Passport No.
                    HStack {
                        Text("Номер паспорта / Passport No.")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Spacer()
                    }.padding(.top, 10)
                    HStack {
                        Text(passport.number)
                            .font(.caption2)
                            .foregroundColor(.black)
                            .bold()
                        Button {
                            copyTapped(text: passport.number)
                        } label: {
                            Image("CopyImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 15)
                                .tint(.secondary)
                        }
                        Spacer()
                    }
                }
                .padding(10)

                Image(.herb)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .tint(.innFontInside)
            }.background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.passportInside)
            }
            .environment(\.colorScheme, .light)
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.passport)
        }
        ShareLink(item: sharePassport(),preview: SharePreview("Паспорт", image: Image("fox"))) {
            Label("Поделиться", systemImage:  "square.and.arrow.up")
                .foregroundColor(.secondary)
                .padding(.vertical, 12)
        }
    }

    private func copyTapped(text: String) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        let copiedText = text.replacingOccurrences(of: " ", with: "")
        UIPasteboard.general.string = copiedText
        feedbackGenerator.impactOccurred()
    }

    private func deleteData() {
        modelContext.delete(passport)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func sharePassport() -> String {
        let rusName = "\(passport.surname) \(passport.givenName)"
        let engName = "\(passport.surnameEng) \(passport.givenNameEng)"
        let dateOfBirth = passport.dateOfBirth
        let gender = passport.gender.rawValue
        let placeOfBirth = passport.placeOfBirth
        let dateOfexpire = passport.dateOfexpire
        let dateOfIssue = passport.dateOfIssue
        let authority = passport.authority
        let number = passport.number

        let passportData = "ФИО РУС: \(rusName)\nФИО АНГЛ: \(engName)\nДата рождения: \(dateOfBirth)\nПол: \(gender)\n Место рождения: \(placeOfBirth)\n Дата выдачи: \(dateOfIssue)\n Дата окончания срока действия: \(dateOfexpire)\n Орган, выдавший документ: \(authority)\n Номер: \(number)"

        return passportData
    }
}

#Preview {
    ShowPassportIntView(passport: PassportIntModel(surname: "ДОБРОВОЛЬСКАЯ", surnameEng: "DOBROVOLSKAYA", givenName: "ЕЛЕНА АЛЕКСАНДРОВНА", givenNameEng: "ELENA", dateOfBirth: "02.04.1997", gender: .f, placeOfBirth: "Г.МОСКВА", placeOfBirthEng: "RUSSIA", dateOfexpire: "02.06.2024", dateOfIssue: "25.05.2019", authority: "ФМС 77718", number: "73 5960757", type: "Загран"))
}
