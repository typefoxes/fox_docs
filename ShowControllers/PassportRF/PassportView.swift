//
//  PassportView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

struct PassportView: View {

    let passport: PassportModel
    var copyAction: (String) -> Void
    var shareAction: String
    var shareTitle: String

    var body: some View {
        VStack {
            Text("РОССИЙСКАЯ ФЕДЕРАЦИЯ")
                .foregroundColor(.passportText)
                .font(.caption)
            VStack {
                VStack(spacing: 1) {
                    HStack {
                        Text("Кем выдан")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    HStack {
                        Text(passport.whoGive)
                            .font(.caption2)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                            .bold()
                            .foregroundColor(.black)

                        Button {
                            copyAction(passport.whoGive)
                        } label: {
                            Image("CopyImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 15)
                                .tint(.secondary)
                        }
                        Spacer()
                    }
                    HStack {
                        VStack(spacing: 5){
                            HStack {
                                Text("Дата выдачи")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(.top, 10)
                            HStack {
                                Text(passport.dateOfVidachy)
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                        VStack(spacing: 5){
                            HStack {
                                Text("Код подразделения")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(.top, 10)
                            HStack {
                                Text(passport.codePodrazdelenia)
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                    }
                    HStack {
                        Text(passport.seriaAndNumber)
                            .font(.title3)
                            .foregroundColor(.passport)
                            .bold()
                        Button {
                            copyAction(passport.seriaAndNumber.replacingOccurrences(of: " ", with: ""))
                        } label: {
                            Image("CopyImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 15)
                                .tint(.secondary)
                        }
                        .padding(.leading, 20)
                        Spacer()
                        Image(.herb)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                            .tint(.innFontInside)
                    }
                }
            }
            .padding(10)
            .environment(\.colorScheme, .light)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.passportInside)
            }
            HStack {
                ForEach(0..<10) { _ in
                    VStack {
                        VStack {
                            Color.gray.frame(height: 1 / UIScreen.main.scale)
                        }
                    }
                }
            }
            VStack {
                HStack(){
                    Image("passportPhoto")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 130)
                        .cornerRadius(10)

                    Spacer()
                    VStack() {
                        HStack() {
                            Text("ФИО")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.top, 5)
                        HStack() {
                            Text(passport.fullName)
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .foregroundColor(.black)
                                .font(.caption2)
                            Spacer()
                        }
                        HStack() {
                            VStack(spacing: 5){
                                HStack() {
                                    Text("Пол")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                                HStack() {
                                    Text(passport.sex.rawValue)
                                        .font(.caption2)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                            }
                            VStack(spacing: 5){
                                HStack() {
                                    Text("Дата рождения")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                                HStack() {
                                    Text(passport.dateOfBirth)
                                        .font(.caption2)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 10)
                        HStack() {
                            Text("Место рождения")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        .padding(.top, 10)
                        HStack() {
                            Text(passport.placeOfBirth)
                                .font(.caption2)
                                .foregroundColor(.black)
                            Spacer()
                        }.padding(.top, 1)
                    }
                }
                ShareLink(item: shareAction,preview: SharePreview(shareTitle, image: Image("fox"))) {
                    Label("Поделиться", systemImage:  "square.and.arrow.up")
                        .foregroundColor(.secondary)
                        .padding(.vertical, 12)
                }
            }
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.passportInside)
            }
            .environment(\.colorScheme, .light)
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.passport)
        }
    }
}
