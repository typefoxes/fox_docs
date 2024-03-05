//
//  InnView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

struct InnBodyView: View {

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

    let inn: INNModel
    var copyAction: (String) -> Void
    var shareAction: String
    
    var body: some View {
        VStack {
            Text(Constants.titleMain)
                .font(.caption)
                .foregroundColor(.innFontTop)
                .padding(.top, Constants.padding)
            
            Text(Constants.titleSecondary)
                .font(.caption2)
                .foregroundColor(.innFontTop)
            
            InnDetailsView(inn: inn, copyAction: copyAction)
        }
        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(.innTop))
        ShareLinkButton(action: shareAction, shareTitle: Constants.typeDoc)
    }
}

struct InnDetailsView: View {

    private enum Constants {
        static let numberTitle: String = "Номер"
        static let nameTitle: String = "ФИО"
        static let dateTitle: String = "Дата рождения"
        static let placeTitle: String = "Место рождения"
        static let genderTitle: String = "Пол"
        static let spacing: CGFloat = 15
        static let cornerRadius: CGFloat = 10
    }

    let inn: INNModel
    var copyAction: (String) -> Void
    
    var body: some View {
        VStack(spacing: Constants.spacing) {
            DetailInnRow(title: Constants.numberTitle, value: inn.number, action: { copyAction(inn.number.replacingOccurrences(of: " ", with: "")) })
            DetailInnRow(title: Constants.nameTitle, value: inn.name)
            HStack {
                DetailInnRow(title: Constants.dateTitle, value: inn.dateOfBirth)
                DetailInnRow(title: Constants.placeTitle, value: inn.placeOfBirth)
            }
            DetailInnRow(title: Constants.genderTitle, value: inn.gender.rawValue)
        }
        .padding(Constants.spacing)
        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(.innInside))
    }
}

struct DetailInnRow: View {

    private enum Constants {
        static let copyImage: Image = Image("CopyImage")
        static let copyImageHeight: CGFloat = 15
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
                    .foregroundColor(.innFontInside)
                if let action = action {
                    Button(action: action) {
                        Constants.copyImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: Constants.copyImageHeight)
                            .tint(.innFontInside)
                    }
                }
                Spacer()
            }
        }
        .padding(.top, action == nil ? .zero : Constants.padding)
    }
}
