//
//  InnDopView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 02.03.2024.
//

import SwiftUI

struct AddInnBodyView: View {

    // MARK: - Constants

    private enum Constants {
        static let mainTitle: String = "СВИДЕТЕЛЬСТВО"
        static let subTitle: String = "О ПОСТАНОВКЕ НА УЧЕТ В НАЛОГОВОМ ОРГАНЕ"
        static let numberTitle: String = "Номер"
        static let numberPlaceholder: String = "XXXX XXXX XXXX"
        static let nameTitle: String = "ФИО"
        static let namePlaceholder: String = "ABCD ABCD ABCD"
        static let dateTitle: String = "Дата рождения"
        static let datePlaceholder: String = "XX.XX.XXXX"
        static let genderTitle: String = "Пол"
        static let placeTitle: String = "Место рождения"
        static let placePlaceholder: String = "New York City..."
        static let padding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let frameHeight: CGFloat = 100
    }
    // MARK: - Properties

    @Binding var number: String
    @Binding var name: String
    @Binding var dateOfBirth: String
    @Binding var placeOfBirth: String
    @Binding var selectedGender: Sex
    @Binding  var genders: [Sex]

    // MARK: - Body

    var body: some View {
        VStack() {
            Text(Constants.mainTitle)
                .font(.caption)
                .foregroundColor(.innFontTop)
                .padding(.top, Constants.padding)
            Text(Constants.subTitle)
                .font(.caption2)
                .foregroundColor(.innFontTop)
            VStack() {
                HStack {
                    VStack {
                        AddField(
                            title: Constants.numberTitle,
                            placeHolder: Constants.numberPlaceholder,
                            changeType: .innNumber,
                            text: $number,
                            keyboardType: .numberPad,
                            titlePosition: .vertical
                        )
                        AddField(
                            title: Constants.nameTitle,
                            placeHolder: Constants.namePlaceholder,
                            changeType: .none,
                            text: $name,
                            keyboardType: .default,
                            titlePosition: .vertical
                        )
                        AddField(
                            title: Constants.dateTitle,
                            placeHolder: Constants.datePlaceholder,
                            changeType: .fullDate,
                            text: $dateOfBirth,
                            keyboardType: .numberPad,
                            titlePosition: .vertical
                        )
                        HStack {
                            GenericMenu(title: Constants.genderTitle,
                                        options: genders,
                                        selection: $selectedGender,
                                        content: {
                                gender in
                                Text(gender.rawValue)
                            },
                                        spacer: true)
                            AddField(
                                title: Constants.placeTitle,
                                placeHolder: Constants.placePlaceholder,
                                changeType: .none,
                                text: $placeOfBirth,
                                keyboardType: .default,
                                titlePosition: .vertical
                            )
                        }
                        .padding(.top, Constants.padding)
                    }
                    .padding(Constants.padding)
                    Image(.herbInn)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: Constants.frameHeight)
                        .tint(.innFontInside)
                }
                .padding(.top, Constants.padding)
                .background {
                    RoundedRectangle(
                        cornerRadius: Constants.cornerRadius,
                        style: .continuous
                    )
                        .fill(.innInside)
                }
            }
        }
        .environment(\.colorScheme, .light)
        .background {
            RoundedRectangle(
                cornerRadius: Constants.cornerRadius,
                style: .continuous
            )
                .fill(.innTop)
        }
    }
}
