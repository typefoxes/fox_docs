//
//  DriveLicenceView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 02.03.2024.
//

import SwiftUI

struct AddDriveLicenceView: View {
    @Binding var surname: String
    @Binding var surnameEng: String
    @Binding var name: String
    @Binding var nameEng: String
    @Binding var dateOfBirth: String
    @Binding var cityOfBirth: String
    @Binding var cityOfBirthEng: String
    @Binding var dateOfIssue: String
    @Binding var dateOfExpire: String
    @Binding var authority: String
    @Binding var number: String
    @Binding var cityOfIssue: String

    @Binding var selectedCategories: [DriveCategory]
    @State private var isShowingPicker = false

    var selectedCategoriesString: String {
        if selectedCategories.isEmpty {
            return "Выбрать"
        } else {
            return selectedCategories.map { $0.rawValue }.joined(separator: ", ")
        }
    }

    var body: some View {
        VStack {
            VStack {
                Text("ВОДИТЕЛЬСКОЕ УДОСТОВЕРЕНИЕ")
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.heavy)
                VStack {
                    VStack {
                        DriveField(title: "1. Фамилия РУС", placeHolder: "XXXX", changeType: .none, text: $surname, keyboardType: .default)
                        DriveField(title: "1. Фамилия АНГЛ", placeHolder: "XXXX", changeType: .none, text: $surnameEng, keyboardType: .default)
                        DriveField(title: "2. Имя Отчество РУС", placeHolder: "XXXX XXXX", changeType: .none, text: $name, keyboardType: .default)
                        DriveField(title: "2. Имя Отчество АНГЛ", placeHolder: "XXXX XXXX", changeType: .none, text: $nameEng, keyboardType: .default)
                        DriveField(title: "3. Дата рождения", placeHolder: "XX.XX.XXXX", changeType: .date, text: $dateOfBirth, keyboardType: .numberPad)
                        DriveField(title: "3a. Город рождения", placeHolder: "XXXXXXXX", changeType: .none, text: $cityOfBirth, keyboardType: .default)
                        DriveField(title: "3b. Город рождения АНГЛ", placeHolder: "XXXXXXXX", changeType: .none, text: $cityOfBirthEng, keyboardType: .default)
                        DriveField(title: "4a. Дата выдачи", placeHolder: "XX.XX.XXXX", changeType: .date, text: $dateOfIssue, keyboardType: .numberPad)
                        DriveField(title: "4b. Окончание срока", placeHolder: "XX.XX.XXXX", changeType: .date, text: $dateOfExpire, keyboardType: .numberPad)
                        DriveField(title: "4c. Кем выдано", placeHolder: "XXXXXXXX XXX", changeType: .none, text: $authority, keyboardType: .default)
                        DriveField(title: "5. Номер", placeHolder: "XX XX XXXXXX", changeType: .number, text: $number, keyboardType: .numberPad)
                        DriveField(title: "8. Город выдачи", placeHolder: "XXXXXXXXXX", changeType: .none, text: $cityOfIssue, keyboardType: .default)

                        HStack {
                            Text("9. Категория")
                                .foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                VStack {
                                    Button(selectedCategoriesString) {
                                        self.isShowingPicker.toggle()
                                    }
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                }
                                .sheet(isPresented: $isShowingPicker) {
                                    NavigationView {
                                        List {
                                            ForEach(DriveCategory.allCases, id: \.self) { category in
                                                MultipleSelectionRow(category: category, isSelected: self.selectedCategories.contains(category)) {
                                                    if self.selectedCategories.contains(category) {
                                                        self.selectedCategories.removeAll(where: { $0 == category })
                                                    } else {
                                                        self.selectedCategories.append(category)
                                                    }
                                                }
                                            }
                                        }
                                        .navigationBarItems(trailing: Button("Сохранить") {
                                            self.isShowingPicker.toggle()
                                        })
                                    }
                                }
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
            .environment(\.colorScheme, .dark)
        }
    }
}
