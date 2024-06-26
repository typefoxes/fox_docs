//
//  PassportView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

struct PassportView: View {
    // MARK: - Constants

    private enum Constants {
        static let titleMain: String = "РОССИЙСКАЯ ФЕДЕРАЦИЯ"
        static let padding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let passportPhoto: Image = Image("passportPhoto")
    }
   
    // MARK: - Properties

    let passport: PassportModel
    var copyAction: (String) -> Void
    var shareAction: String
    var shareTitle: String

    // MARK: - Body

    var body: some View {
        VStack(spacing: Constants.padding) {
            Text(Constants.titleMain)
                .foregroundColor(.passportText)
                .font(.caption)

            PassportDetailsView(
                passport: passport,
                copyAction: copyAction
            )
            DividerView()
            PassportPhotoView(
                image: Constants.passportPhoto,
                fullName: passport.fullName,
                sex: passport.sex.rawValue,
                dateOfBirth: passport.dateOfBirth,
                placeOfBirth: passport.placeOfBirth,
                shareAction: shareAction,
                shareTitle: shareTitle
            )

        }
        .padding(Constants.padding)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.passport)
        )
    }
}

// MARK: - PassportDetailsView

struct PassportDetailsView: View {

    private enum Constants {
        static let whoGiveTitle: String = "Кем выдан"
        static let dateTitle: String = "Дата выдачи"
        static let codeTitle: String = "Код подразделения"
        static let spacing: CGFloat = 10
        static let cornerRadius: CGFloat = 10
    }

    let passport: PassportModel
    var copyAction: (String) -> Void

    func whoGiveCopyAction() {
        copyAction(passport.whoGive)
    }

    func numberCopyAction() {
        copyAction(passport.seriaAndNumber)
    }
    var body: some View {
        VStack(spacing: Constants.spacing) {
            DetailRow(title: Constants.whoGiveTitle, value: passport.whoGive, position: .vertical, textColor: .passportText, action: whoGiveCopyAction)
            HStack(spacing: Constants.spacing) {
                DetailRow(title: Constants.dateTitle, value: passport.dateOfVidachy, position: .vertical, textColor: .passportText)
                DetailRow(title: Constants.codeTitle, value: passport.codePodrazdelenia, position: .vertical, textColor: .passportText)
            }
            DetailRow(title: .empty, value: passport.seriaAndNumber, position: .none, textColor: .passportText, action: numberCopyAction)
        }
        .padding(Constants.spacing)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.passportInside)
        )
    }
}

struct PassportPhotoView: View {
    // MARK: - Constants

    private enum Constants {
        static let padding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let imageFrame: CGFloat = 130
        static let nameTitle: String = "ФИО"
        static let genderTitle: String = "Пол"
        static let dateOfBirthTitle: String = "Дата рождения"
        static let placeOfBirthTitle: String = "Место рождения"
    }

    // MARK: - Properties

    let image: Image
    let fullName: String
    let sex: String
    let dateOfBirth: String
    let placeOfBirth: String
    var shareAction: String
    var shareTitle: String
    
    // MARK: - Body

    var body: some View {
        VStack {
            HStack {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constants.imageFrame)
                    .cornerRadius(Constants.cornerRadius)

                VStack(alignment: .leading, spacing: Constants.padding) {
                    DetailRow(
                        title: Constants.nameTitle,
                        value: fullName,
                        position: .vertical,
                        textColor: .passportText
                    )
                    HStack {
                        DetailRow(
                            title: Constants.genderTitle,
                            value: sex,
                            position: .vertical,
                            textColor: .passportText
                        )
                        DetailRow(
                            title: Constants.dateOfBirthTitle,
                            value: dateOfBirth,
                            position: .vertical,
                            textColor: .passportText
                        )
                    }

                    DetailRow(
                        title: Constants.placeOfBirthTitle,
                        value: placeOfBirth,
                        position: .vertical,
                        textColor: .passportText
                    )
                }
            }

            ShareLinkButton(
                action: shareAction,
                shareTitle: shareTitle
            )
        }
        .padding(Constants.padding)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.passportInside)
        )
    }
}
