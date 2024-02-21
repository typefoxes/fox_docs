//
//  PassportView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

struct PassportView: View {
    
    private enum Constants {
        static let titleMain: String = "РОССИЙСКАЯ ФЕДЕРАЦИЯ"
        static let padding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let passportPhoto: Image = Image("passportPhoto")
    }
    
    let passport: PassportModel
    var copyAction: (String) -> Void
    var shareAction: String
    var shareTitle: String

    var body: some View {
        VStack(spacing: Constants.padding) {
            Text(Constants.titleMain)
                .foregroundColor(.passportText)
                .font(.caption)

            PassportDetailsView(passport: passport, copyAction: copyAction)

            Divider()

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

    var body: some View {
        VStack(spacing: Constants.spacing) {
            TextWithCopyButton(title: Constants.whoGiveTitle, text: passport.whoGive, copyAction: copyAction)
            HStack(spacing: Constants.spacing) {
                TextWithDetail(title: Constants.dateTitle, detail: passport.dateOfVidachy)
                TextWithDetail(title: Constants.codeTitle, detail: passport.codePodrazdelenia)
            }

            HStack {
                Text(passport.seriaAndNumber)
                    .font(.title3)
                    .foregroundColor(.passport)
                    .bold()

                CopyButton(text: passport.seriaAndNumber.replacingOccurrences(of: " ", with: ""), copyAction: copyAction)
                Spacer()
            }
        }
        .padding(Constants.spacing)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.passportInside)
        )
    }
}

struct TextWithCopyButton: View {
    
    private enum Constants {
        static let lineLimit: Int = 3
    }
    
    let title: String
    let text: String
    var copyAction: (String) -> Void

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack {
                Text(text)
                    .font(.caption2)
                    .multilineTextAlignment(.leading)
                    .lineLimit(Constants.lineLimit)
                    .bold()
                    .foregroundColor(.black)
                
                CopyButton(text: text, copyAction: copyAction)
                Spacer()
            }
        }
    }
}

struct TextWithDetail: View {
    
    private enum Constants {
        static let spacing: CGFloat = 5
        static let padding: CGFloat = 10
    }
    
    let title: String
    let detail: String

    var body: some View {
        VStack(spacing: Constants.spacing) {
            HStack {
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
            }

            HStack {
                Text(detail)
                    .font(.caption2)
                    .foregroundColor(.black)
                Spacer()
            }
        }
        .padding(.top, Constants.padding)
    }
}

struct CopyButton: View {
    
    private enum Constants {
        static let copyImage: Image = Image("CopyImage")
        static let copyImageHeight: CGFloat = 15
    }
    
    let text: String
    var copyAction: (String) -> Void

    var body: some View {
        Button(action: {
            copyAction(text)
        }) {
            Constants.copyImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: Constants.copyImageHeight)
                .tint(.secondary)
        }
    }
}

struct PassportPhotoView: View {

    private enum Constants {
        static let padding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
    }

    let image: Image
    let fullName: String
    let sex: String
    let dateOfBirth: String
    let placeOfBirth: String
    var shareAction: String
    var shareTitle: String

    var body: some View {
        VStack {
            HStack {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 130)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 15) {
                    VStack() {
                        HStack {
                            Text("ФИО")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        HStack {
                            Text(fullName)
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .font(.caption2)
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                    HStack {
                        VStack {
                            HStack {
                                Text("Пол")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            HStack {
                                Text(sex)
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                        VStack {
                            HStack {
                                Text("Дата рождения")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            HStack {
                                Text(dateOfBirth)
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                    }
                    VStack {
                        HStack {
                            Text("Место рождения")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        HStack {
                            Text(placeOfBirth)
                                .font(.caption2)
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                }
            }
            ShareLinkButton(action: shareAction, shareTitle: shareTitle)
        }
        .padding(Constants.padding)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.passportInside)
        )
    }
}
