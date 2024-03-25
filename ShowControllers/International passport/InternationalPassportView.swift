//
//  InternationalPassportView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

struct InternationalPassportView: View {

    // MARK: - Properties

    let passport: PassportIntModel
    var copyAction: (String) -> Void
    var shareAction: String

    // MARK: - Constants
    private enum Constants {
        static let titleRussiaFederation: String = "РОССИЙСКАЯ ФЕДЕРАЦИЯ / RUSSIAN FEDERATION"
        static let surnameTitle: String = "Фамилия / Surname"
        static let givenNameTitle: String = "Имя / Given name"
        static let dateOfBirthTitle: String = "Дата рождения / Date of birth"
        static let sexTitle: String = "Пол / Sex"
        static let placeOfBirthTitle: String = "Место рождения / Place of birth"
        static let dateOfIssueTitle: String = "Дата выдачи / Date of issue"
        static let dateOfExpireTitle: String = "Дата окончания срока действия / Date of expire"
        static let authorityTitle: String = "Орган, выдавший документ / Authority"
        static let passportNoTitle: String = "Номер паспорта / Passport No."
        static let passportType: String = "Загранпаспорт"
        static let appImage: Image = Image("fox")
        static let shareLinkLabel: String = "Поделиться"
        static let shareLinkImage: String = "square.and.arrow.up"
        static let copyImage: Image = Image("CopyImage")
        static let photoHeight: CGFloat = 110
        static let copyImageHeight: CGFloat = 15
        static let padding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
    }

    // MARK: - Body

    var body: some View {
        VStack {
            Text(Constants.titleRussiaFederation)
                .font(.caption)
                .foregroundColor(.passportText)
            VStack {
                HStack {
                    passportInformation()
                }
            }
            .padding(Constants.padding)
            .background(
                RoundedRectangle(
                    cornerRadius: Constants.cornerRadius,
                    style: .continuous
                ).fill(
                    Color.passportInside
                )
            )
            .environment(\.colorScheme, .light)
            DividerView()
            VStack() {
                HStack {
                    Image(.passportPhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: Constants.photoHeight)
                        .cornerRadius(Constants.cornerRadius)
                    importantDates()
                }
            }
            .padding(Constants.padding)
            .background(
                RoundedRectangle(
                    cornerRadius: Constants.cornerRadius,
                    style: .continuous
                ).fill(
                    Color.passportInside
                )
            )
            .environment(\.colorScheme, .light)
        }
        .padding(Constants.padding)
        .background(
            RoundedRectangle(
                cornerRadius: Constants.cornerRadius,
                style: .continuous
            ).fill(
                Color.passport
            )
        )
        ShareLinkButton(
            action: shareAction,
            shareTitle: Constants.passportType
        )
    }

    // MARK: - Private functions

    private func passportInformation() -> some View {
        VStack(
            spacing: Constants.padding
        ) {
            DetailRow(
                title: Constants.surnameTitle,
                value: "\(passport.surname)",
                position: .vertical,
                textColor: .passportText
            )
            DetailRow(
                title: Constants.givenNameTitle,
                value: "\(passport.givenName)",
                position: .vertical,
                textColor: .passportText
            )
            HStack {
                DetailRow(
                    title: Constants.sexTitle,
                    value: "\(passport.gender.rawValue)",
                    position: .vertical,
                    textColor: .passportText
                )
                DetailRow(
                    title: Constants.dateOfBirthTitle,
                    value: "\(passport.dateOfBirth)",
                    position: .vertical,
                    textColor: .passportText
                )
            }
            DetailRow(
                title: Constants.placeOfBirthTitle,
                value: "\(passport.placeOfBirth)",
                position: .vertical,
                textColor: .passportText
            )
        }
    }

    private func importantDates() -> some View {
        VStack(
            spacing: Constants.padding
        ) {
            DetailRow(
                title: Constants.dateOfIssueTitle,
                value: "\(passport.dateOfIssue)",
                position: .vertical,
                textColor: .passportText
            )
            DetailRow(
                title: Constants.dateOfExpireTitle,
                value: "\(passport.dateOfexpire)",
                position: .vertical,
                textColor: .passportText
            )
            DetailRow(
                title: Constants.authorityTitle,
                value: "\(passport.authority)",
                position: .vertical,
                textColor: .passportText
            )
            DetailRow(title: Constants.passportNoTitle,
                      value: "\(passport.number)",
                      position: .vertical,
                      textColor: .passportText,
                      action: {
                copyAction(
                    passport.number
                )
            })
        }
    }
}
