//
//  SnilsView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

struct SnilsView: View {

    // MARK: - Constants

    private enum Constants {
        static let titleMain: String = "СТРАХОВОЕ СВИДЕТЕЛЬСТВО"
        static let titleSecondary: String = "ОБЯЗАТЕЛЬНОГО ПЕНСИОННОГО СТРАХОВАНИЯ"
        static let sharePreview: String = "СНИЛС"
        static let appImage: Image = Image("fox")
        static let shareLabel: String = "Поделиться"
        static let shareSystemImage: String = "square.and.arrow.up"
        static let cornerRadius: CGFloat = 10
        static let paddingVertical: CGFloat = 10

    }

    // MARK: - Properties

    let snils: SnilsModel
    var copyAction: (String) -> Void
    var shareAction: String

    // MARK: - Body

    var body: some View {
        VStack {
            Text(Constants.titleMain)
                .font(.caption)
                .foregroundColor(Color.snilsTop)
                .padding(.top, Constants.paddingVertical)

            Text(Constants.titleSecondary)
                .font(.caption2)
                .foregroundColor(Color.snilsTop)

            SnilsDetailsView(
                snils: snils,
                copyAction: copyAction
            )
        }
        .background(
            RoundedRectangle(
                cornerRadius: Constants.cornerRadius,
                style: .continuous
            )
                .fill(Color.snilsHead)
        )
        ShareLinkButton(
            action: shareAction,
            shareTitle: Constants.sharePreview
        )
    }
}

// MARK: - SnilsDetailsView

struct SnilsDetailsView: View {

    // MARK: - Constants

    private enum Constants {
        static let titleNumber: String = "Номер"
        static let titleName: String = "ФИО"
        static let titleDate: String = "Дата и место рождения"
        static let titleGender: String = "Пол"
        
        static let spacing: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let padding: CGFloat = 20
    }
 
    // MARK: - Properties

    let snils: SnilsModel
    var copyAction: (String) -> Void

    // MARK: - Body

    var body: some View {
        VStack(spacing: Constants.spacing) {
            DetailRow(title: Constants.titleNumber,
                      value: snils.number,
                      position: .vertical,
                      textColor: .primary,
                      action: {
                copyAction(
                    snils.number
                )
            })
            DetailRow(
                title: Constants.titleName,
                value: snils.name,
                position: .vertical,
                textColor: .primary
            )
            DetailRow(
                title: Constants.titleDate,
                value: snils.dateAndPlace,
                position: .vertical,
                textColor: .primary
            )
            DetailRow(
                title: Constants.titleGender,
                value: snils.sex.rawValue,
                position: .vertical,
                textColor: .primary
            )
        }
        .padding(.horizontal, Constants.padding)
        .padding(.top, Constants.spacing)
        .padding(.bottom, Constants.padding)
        .environment(\.colorScheme, .light)
        .background(
            RoundedRectangle(
                cornerRadius: Constants.cornerRadius,
                style: .continuous
            )
                .fill(Color.snils)
        )
    }
}
