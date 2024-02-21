//
//  PassportView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

import SwiftUI

struct PassportView: View {
    
    let passport: PassportModel
    var copyAction: (String) -> Void
    var shareAction: String
    var shareTitle: String

    var body: some View {
        VStack(spacing: 10) {
            Text("РОССИЙСКАЯ ФЕДЕРАЦИЯ")
                .foregroundColor(.passportText)
                .font(.caption)

            VStack(spacing: 20) {
                    TextWithCopyButton(title: "Кем выдан", text: passport.whoGive, copyAction: copyAction)
               HStack(spacing: 10) {
                    TextWithDetail(title: "Дата выдачи", detail: passport.dateOfVidachy)
                    TextWithDetail(title: "Код подразделения", detail: passport.codePodrazdelenia)
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
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.passportInside)
            )

            Divider()

            VStack(spacing: 10) {
                PassportPhotoView(image: Image("passportPhoto"), fullName: passport.fullName, sex: passport.sex.rawValue, dateOfBirth: passport.dateOfBirth, placeOfBirth: passport.placeOfBirth)
                
                ShareLinkButton(action: shareAction, shareTitle: shareTitle)
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.passportInside)
            )
            .environment(\.colorScheme, .light)
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.passport)
        )
    }
}

struct TextWithCopyButton: View {
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
                    .lineLimit(3)
                    .bold()
                    .foregroundColor(.black)
                
                CopyButton(text: text, copyAction: copyAction)
                Spacer()
            }
        }
    }
}

struct TextWithDetail: View {
    let title: String
    let detail: String

    var body: some View {
        VStack(spacing: 5) {
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
        .padding(.top, 10)
    }
}

struct CopyButton: View {
    let text: String
    var copyAction: (String) -> Void

    var body: some View {
        Button(action: {
            copyAction(text)
        }) {
            Image("CopyImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 15)
                .tint(.secondary)
        }
    }
}

struct PassportPhotoView: View {
    let image: Image
    let fullName: String
    let sex: String
    let dateOfBirth: String
    let placeOfBirth: String

    var body: some View {
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
    }
}

struct ShareLinkButton: View {
    var action: String
    var shareTitle: String

    var body: some View {
        ShareLink(item: action, preview: SharePreview(shareTitle, image: Image("fox"))) {
            Label("Поделиться", systemImage: "square.and.arrow.up")
                .foregroundColor(.secondary)
                .padding(.vertical, 12)
        }
    }
}
