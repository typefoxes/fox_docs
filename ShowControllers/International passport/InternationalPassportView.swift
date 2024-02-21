//
//  InternationalPassportView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

struct InternationalPassportView: View {
    
    let passport: PassportIntModel
    var copyAction: (String) -> Void
    var shareAction: String
    
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
            .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(Color.passportInside))
            .environment(\.colorScheme, .light)
            divider()
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
            .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(Color.passportInside))
            .environment(\.colorScheme, .light)
        }
        .padding(Constants.padding)
        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(Color.passport))
        ShareLinkButton(action: shareAction, shareTitle: Constants.passportType)
    }
    
    private func passportInformation() -> some View {
        VStack(spacing: Constants.padding) {
            passportInfoRow(title: Constants.surnameTitle, value: "\(passport.surname) / \(passport.surnameEng)")
            passportInfoRow(title: Constants.givenNameTitle, value: "\(passport.givenName) / \(passport.givenNameEng)")
            HStack {
                passportInfoRow(title: Constants.sexTitle, value: "\(passport.gender.rawValue)")
                passportInfoRow(title: Constants.dateOfBirthTitle, value: "\(passport.dateOfBirth)")
            }
            passportInfoRow(title: Constants.placeOfBirthTitle, value: "\(passport.placeOfBirth) / \(passport.placeOfBirthEng)")
        }
    }
    
    private func importantDates() -> some View {
        VStack(spacing: Constants.padding) {
            passportInfoRow(title: Constants.dateOfIssueTitle, value: "\(passport.dateOfIssue)")
            passportInfoRow(title: Constants.dateOfExpireTitle, value: "\(passport.dateOfexpire)")
            passportInfoRow(title: Constants.authorityTitle, value: "\(passport.authority)")
            passportInfoRow(title: Constants.passportNoTitle, value: "\(passport.number)", isBold: true, action: {
                copyAction(passport.number)
            })
        }
    }
    
    
    private func passportInfoRow(title: String, value: String, isBold: Bool = false, action: (() -> Void)? = nil) -> some View {
        VStack { HStack {
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
            Spacer()
        }.padding(.top, Constants.padding)
            HStack {
                Text(value)
                    .font(isBold ? .caption2.bold() : .caption2)
                    .foregroundColor(.black)
                if let action = action {
                    Button(action: action) {
                        Constants.copyImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: Constants.copyImageHeight)
                            .tint(.secondary)
                    }
                }
                Spacer()
            }
        }
    }
    
    private func divider() -> some View {
        HStack {
            ForEach(0..<10) { _ in
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
            }
        }
    }
}
