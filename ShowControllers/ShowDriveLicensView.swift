//
//  AddDriveLicensView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct ShowDriveLicensView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var showAlert = false

    let drive: DriveModel

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Водительское удостоверение")
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
                          //  deleteData()
                            presentationMode.wrappedValue.dismiss()
                        }
                        )
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
            VStack {
                Text("ВОДИТЕЛЬСКОЕ УДОСТОВЕРЕНИЕ")
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.heavy)
                VStack {
                    VStack {
                        HStack {
                            Text("1.   ").foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                Text("\(drive.surname) / \(drive.surnameEng)")
                                    .foregroundColor(.white)
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("2.   ").foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                Text("\(drive.name) / \(drive.nameEng)")
                                    .foregroundColor(.white)
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("3.   ").foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            Text("\(drive.dateOfBirth)")
                                .foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        HStack {
                            Text("3a.  ").foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            Text("\(drive.cityOfBirth)")
                                .foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        HStack {
                            Text("4a. ")
                                .foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                Text("\(drive.dateOfIssue)")
                                    .foregroundColor(.white)
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("4b. ")
                                .foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                Text("\(drive.dateOfExpire)")
                                    .foregroundColor(.white)
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("4c. ")
                                .foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                Text("\(drive.authority)")
                                    .foregroundColor(.white)
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("5.   ")
                                .foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                Text("\(drive.number)")
                                    .foregroundColor(.white)
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("6.   ")
                                .foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                Text("---")
                                    .foregroundColor(.white)
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("7.    ")
                                .foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                Text("---")
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("8.   ")
                                .foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                Text("\(drive.cityOfIssue)")
                                    .foregroundColor(.white)
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("9.   ")
                                .foregroundColor(.white)
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                Text(drive.category.map { String(describing: $0.rawValue) }.joined(separator: ", ")).foregroundColor(.white)
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                        }
                    }.padding()
                }

                .background {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.linearGradient(colors: [Color.indigo, Color.cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.linearGradient(colors: [Color.blue, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing)) }
            .padding(5)
            ShareLink(item: shareDrive(),preview: SharePreview("Водительское удостоверение", image: Image("fox"))) {
                Label("Поделиться", systemImage:  "square.and.arrow.up")
                    .foregroundColor(.secondary)
                    .padding(.vertical, 12)
            }
        }
    }

    private func deleteData() {
        modelContext.delete(drive)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func shareDrive() -> String {
        let nameRus = "\(drive.surname) \(drive.name)"
        let nameEng = "\(drive.surnameEng) \(drive.nameEng)"
        let dateOfBirth = drive.dateOfBirth
        let cityOfBirth = "\(drive.cityOfBirth) / \(drive.cityOfBirthEng)"
        let dateOfIssue = drive.dateOfIssue
        let dateOfExpire = drive.dateOfExpire
        let authority = drive.authority
        let number = drive.number
        let category = drive.category.map { String(describing: $0.rawValue) }.joined(separator: ", ")
        let cityOfIssue = drive.cityOfIssue


        let driveData = "ФИО РУС: \(nameRus)\nФИО АНГЛ: \(nameEng)\nДата рождения: \(dateOfBirth)\nГород рождения: \(cityOfBirth)\nДата получения: \(dateOfIssue)\nДата окончания срока: \(dateOfExpire)\nВыдан: \(authority)\nНомер: \(number)\nГород получения: \(cityOfIssue)\nКатегория: \(category)"

        return driveData
    }
}

#Preview {
    ShowDriveLicensView(drive: DriveModel(surname: "КОТИНА", surnameEng: "KOTINA", name: "ДАРЬЯ СЕРГЕЕВНА", nameEng: "DARIA SERGEEVNA", dateOfBirth: "02.04.1997", cityOfBirth: "МОСКВА", cityOfBirthEng: "MOSKVA", dateOfIssue: "23.07.2017", dateOfExpire: "23.07.2027", authority: "ГИБДД 7724", number: "77 33 124234", category: [.b, .b1, .m], cityOfIssue: "МОСКВА"))
}
