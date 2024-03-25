//
//  DriveLicenceView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 02.03.2024.
//

import SwiftUI

struct AddDriveBodyView: View {

    // MARK: - Constants
    
    private enum Constants {
        static let selectedCategoriesDefault: String = "Выбрать"
        static let selectedCategoriesSeparator: String = ", "
        static let title: String = "ВОДИТЕЛЬСКОЕ УДОСТОВЕРЕНИЕ"
        static let padding: CGFloat = 10
        static let surnameItemRus: String = "1. Фамилия РУС"
        static let surnameItemEng: String = "1. Фамилия АНГ"
        static let placeHolderText: String = "XXXXXX"
        static let numberPlaceHolder: String = "XX XX XXXXXX"
        static let nameRus: String = "2. Имя Отчество РУС"
        static let nameEng: String = "2. Имя Отчество АНГ"
        static let dateOfBirth: String = "3. Дата рождения"
        static let datePlaceholder: String = "XX.XX.XXXX"
        static let cityOfBirthRus: String = "3a. Город рождения РУС"
        static let cityOfBirthEng: String = "3b. Город рождения АНГ"
        static let dateOfIssue: String = "4a. Дата выдачи"
        static let dateOfExpire: String = "4b. Окончание срока"
        static let authority: String = "4c. Кем выдано"
        static let number: String = "5. Номер"
        static let cityOfIssue: String = "8. Город выдачи"
        static let category: String = "9. Категория"
        static let navigationBarItem: String = "Сохранить"
        static let cornerRadius: CGFloat = 20
    }

    // MARK: - Properties

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
    var selectedCategoriesString: String {
        if selectedCategories.isEmpty {
            return Constants.selectedCategoriesDefault
        } else {
            return selectedCategories.map { $0.rawValue }.joined(separator: Constants.selectedCategoriesSeparator)
        }
    }

    // MARK: - Private properties

    @State private var isShowingPicker = false

    // MARK: - Body

    var body: some View {
        VStack {
            VStack {
                Text(Constants.title)
                    .foregroundColor(.white)
                    .padding(.top, Constants.padding)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.heavy)
                VStack {
                    VStack {
                        AddField(
                            title: Constants.surnameItemRus,
                            placeHolder: Constants.placeHolderText,
                            changeType: .none,
                            text: $surname,
                            keyboardType: .default,
                            titlePosition: .horizontal
                        )
                        AddField(
                            title: Constants.surnameItemEng,
                            placeHolder: Constants.placeHolderText,
                            changeType: .none,
                            text: $surnameEng,
                            keyboardType: .default,
                            titlePosition: .horizontal
                        )
                        AddField(
                            title: Constants.nameRus,
                            placeHolder: Constants.placeHolderText,
                            changeType: .none,
                            text: $name,
                            keyboardType: .default,
                            titlePosition: .horizontal
                        )
                        AddField(
                            title: Constants.nameEng,
                            placeHolder: Constants.placeHolderText,
                            changeType: .none,
                            text: $nameEng,
                            keyboardType: .default,
                            titlePosition: .horizontal
                        )
                        AddField(
                            title: Constants.dateOfBirth,
                            placeHolder: Constants.datePlaceholder,
                            changeType: .date,
                            text: $dateOfBirth,
                            keyboardType: .numberPad,
                            titlePosition: .horizontal
                        )
                        AddField(
                            title: Constants.cityOfBirthRus,
                            placeHolder: Constants.placeHolderText,
                            changeType: .none,
                            text: $cityOfBirth,
                            keyboardType: .default,
                            titlePosition: .horizontal
                        )
                        AddField(
                            title: Constants.cityOfBirthEng,
                            placeHolder: Constants.placeHolderText,
                            changeType: .none,
                            text: $cityOfBirthEng,
                            keyboardType: .default,
                            titlePosition: .horizontal
                        )
                        AddField(
                            title: Constants.dateOfIssue,
                            placeHolder: Constants.datePlaceholder,
                            changeType: .date,
                            text: $dateOfIssue,
                            keyboardType: .numberPad,
                            titlePosition: .horizontal
                        )
                        AddField(
                            title: Constants.dateOfExpire,
                            placeHolder: Constants.datePlaceholder,
                            changeType: .date,
                            text: $dateOfExpire,
                            keyboardType: .numberPad,
                            titlePosition: .horizontal
                        )
                        AddField(
                            title: Constants.authority,
                            placeHolder: Constants.placeHolderText,
                            changeType: .none,
                            text: $authority,
                            keyboardType: .default,
                            titlePosition: .horizontal
                        )
                        AddField(
                            title: Constants.number,
                            placeHolder: Constants.numberPlaceHolder,
                            changeType: .cardNumber,
                            text: $number,
                            keyboardType: .numberPad,
                            titlePosition: .horizontal
                        )
                        AddField(
                            title: Constants.cityOfIssue,
                            placeHolder: Constants.placeHolderText,
                            changeType: .none,
                            text: $cityOfIssue,
                            keyboardType: .default,
                            titlePosition: .horizontal
                        )
                        HStack {
                            Text(Constants.category)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            HStack {
                                Spacer()
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
                                                MultipleSelectionRow(
                                                    category: category,
                                                    isSelected: self.selectedCategories.contains(category)
                                                ) {
                                                    if self.selectedCategories.contains(category) {
                                                        self.selectedCategories.removeAll(where: { $0 == category })
                                                    } else {
                                                        self.selectedCategories.append(category)
                                                    }
                                                }
                                            }
                                        }
                                        .navigationBarItems(trailing: Button(Constants.navigationBarItem) {
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
                    RoundedRectangle(
                        cornerRadius: Constants.cornerRadius,
                        style: .continuous
                    )
                    .fill(
                        .linearGradient(
                            colors: [
                                Color.indigo,
                                Color.cyan
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                }
            }
            .background {
                RoundedRectangle(
                    cornerRadius: Constants.cornerRadius,
                    style: .continuous
                )
                .fill(
                    .linearGradient(
                        colors: [
                            Color.blue,
                            Color.green
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            }
            .padding(Constants.padding)
            .environment(\.colorScheme, .dark)
        }
    }
}
