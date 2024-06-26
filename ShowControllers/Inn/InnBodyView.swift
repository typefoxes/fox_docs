//
//  InnView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

struct InnBodyView: View {

    // MARK: - Constants

    private enum Constants {
        static let titleMain: String = "СВИДЕТЕЛЬСТВО"
        static let titleSecondary: String = "О ПОСТАНОВКЕ НА УЧЕТ В НАЛОГОВОМ ОРГАНЕ"
        static let typeDoc: String = "ИНН"
        static let shareLabel: String = "Поделиться"
        static let sharePic: String = "square.and.arrow.up"
        static let appImage: Image = Image("fox")
        static let cornerRadius: CGFloat = 10
        static let padding: CGFloat = 10
    }

    // MARK: - Properties

    let inn: INNModel
    var copyAction: (String) -> Void
    var shareAction: String
    
    // MARK: - Body

    var body: some View {
        VStack {
            Text(Constants.titleMain)
                .font(.caption)
                .foregroundColor(.innFontTop)
                .padding(.top, Constants.padding)
            
            Text(Constants.titleSecondary)
                .font(.caption2)
                .foregroundColor(.innFontTop)
            
            InnDetailsView(
                inn: inn,
                copyAction: copyAction
            )
        }
        .background(
            RoundedRectangle(
                cornerRadius: Constants.cornerRadius,
                style: .continuous
            ).fill(
                .innTop
            )
        )
        ShareLinkButton(
            action: shareAction,
            shareTitle: Constants.typeDoc
        )
    }
}

// MARK: - InnDetailsView

struct InnDetailsView: View {

    // MARK: - Constants

    private enum Constants {
        static let numberTitle: String = "Номер"
        static let nameTitle: String = "ФИО"
        static let dateTitle: String = "Дата рождения"
        static let placeTitle: String = "Место рождения"
        static let genderTitle: String = "Пол"
        static let spacing: CGFloat = 15
        static let cornerRadius: CGFloat = 10
    }

    // MARK: - Properties

    let inn: INNModel
    var copyAction: (String) -> Void
    
    // MARK: - Body

    var body: some View {
        VStack(
            spacing: Constants.spacing
        ) {
            DetailRow(title: Constants.numberTitle,
                      value: inn.number,
                      position: .vertical,
                      textColor: .innFontInside,
                      action: {
                copyAction(
                    inn.number.replacingOccurrences(
                        of: " ",
                        with: ""
                    )
                )
            })
            DetailRow(
                title: Constants.nameTitle,
                value: inn.name,
                position: .vertical,
                textColor: .innFontInside
            )
            HStack {
                DetailRow(
                    title: Constants.dateTitle,
                    value: inn.dateOfBirth,
                    position: .vertical,
                    textColor: .innFontInside
                )
                DetailRow(
                    title: Constants.placeTitle,
                    value: inn.placeOfBirth,
                    position: .vertical,
                    textColor: .innFontInside
                )
            }
            DetailRow(
                title: Constants.genderTitle,
                value: inn.gender.rawValue,
                position: .vertical,
                textColor: .innFontInside
            )
        }
        .padding(
            Constants.spacing
        )
        .background(
            RoundedRectangle(
                cornerRadius: Constants.cornerRadius,
                style: .continuous
            ).fill(
                .innInside
            )
        )
    }
}
