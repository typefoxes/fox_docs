//
//  SnilsView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

struct SnilsView: View {

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

    let snils: SnilsModel
    var copyAction: (String) -> Void
    var shareAction: String

    var body: some View {
        VStack {
            Text(Constants.titleMain)
                .font(.caption)
                .foregroundColor(Color.snilsTop)
                .padding(.top, Constants.paddingVertical)

            Text(Constants.titleSecondary)
                .font(.caption2)
                .foregroundColor(Color.snilsTop)

            SnilsDetailsView(snils: snils, copyAction: copyAction)
        }
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .fill(Color.snilsHead)
        )
        ShareLinkButton(action: shareAction, shareTitle: Constants.sharePreview)
    }
}

struct SnilsDetailsView: View {

    private enum Constants {
        static let titleNumber: String = "Номер"
        static let titleName: String = "ФИО"
        static let titleDate: String = "Дата и место рождения"
        static let titleGender: String = "Пол"
        
        static let spacing: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let padding: CGFloat = 20
    }
 
    let snils: SnilsModel
    var copyAction: (String) -> Void

    var body: some View {
        VStack(spacing: Constants.spacing) {
            DetailSnilsRow(title: Constants.titleNumber, value: snils.number, action: { copyAction(snils.number) })
            DetailSnilsRow(title: Constants.titleName, value: snils.name)
            DetailSnilsRow(title: Constants.titleDate, value: snils.dateAndPlace)
            DetailSnilsRow(title: Constants.titleGender, value: snils.sex.rawValue)
        }
        .padding(.horizontal, Constants.padding)
        .padding(.top, Constants.spacing)
        .padding(.bottom, Constants.padding)
        .environment(\.colorScheme, .light)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .fill(Color.snils)
        )
    }
}

struct DetailSnilsRow: View {

    private enum Constants {
        static let copyImage: Image = Image("CopyImage")
        
        static let imageHeight: CGFloat = 15
        static let padding: CGFloat = 10
    }
 
    let title: String
    let value: String
    var action: (() -> Void)? = nil

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack {
                Text(value)
                    .font(.caption)
                    .foregroundColor(.black)
                if let action = action {
                    Button(action: action) {
                        Constants.copyImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: Constants.imageHeight)
                            .tint(.secondary)
                    }
                }
                Spacer()
            }
        }
        .padding(.top, action == nil ? .zero : Constants.padding)
    }
}
