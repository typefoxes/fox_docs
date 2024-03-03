//
//  AddSnilsBody.swift
//  Fox Docs
//
//  Created by Дарья Котина on 03.03.2024.
//

import SwiftUI
struct AddSnilsBodyView: View {
    private enum Constants {
        static let number: String = "Номер"
        static let numberPlaceholder: String = "XXX-XXX-XXX XX"
        static let name: String = "ФИО"
        static let namePlaceholder: String = "ABCD ABCD ABCD"
        static let dateAndPlace: String = "Дата и место рождения"
        static let dateAndPlacePlaceholder: String = "02 апреля 1997 года Москва"
        static let gender: String = "Пол"
        static let spacing: CGFloat = 20
        static let frameHeight: CGFloat = 260
        static let cornerRadius: CGFloat = 10
    }

    @Binding var number: String
    @Binding var name: String
    @Binding var dateAndPlace: String
    @Binding var selectedSex: Sex
    private let sex: [Sex] = [.female, .male]

    var body: some View {
        VStack {
            MainTitleView()
            VStack() {
                VStack(spacing: Constants.spacing) {
                    AddField(title: Constants.number, placeHolder: Constants.numberPlaceholder, changeType: .snilsNumber, text: $number, keyboardType: .numberPad, titlePosition: .vertical)
                    AddField(title: Constants.name, placeHolder: Constants.namePlaceholder, changeType: .none, text: $name, keyboardType: .default, titlePosition: .vertical)
                    AddField(title: Constants.dateAndPlace, placeHolder: Constants.dateAndPlacePlaceholder, changeType: .none, text: $dateAndPlace, keyboardType: .default, titlePosition: .vertical)
                    GenericMenu(title: Constants.gender, options: sex, selection: $selectedSex, content: {
                        gender in Text(gender.rawValue)
                    }, spacer: true)
                }.padding(Constants.spacing)
            }
            .frame(height: Constants.frameHeight)
            .environment(\.colorScheme, .light)
            .background {
                RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                    .fill(Color.snils)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .fill(Color.snilsHead)
        }
    }
}

struct MainTitleView: View {

    private enum Constants {
        static let title: String = "СТРАХОВОЕ СВИДЕТЕЛЬСТВО"
        static let subTitle: String = "ОБЯЗАТЕЛЬНОГО ПЕНСИОННОГО СТРАХОВАНИЯ"
        static let padding: CGFloat = 10
    }

    var body: some View {
        VStack {
            Text(Constants.title)
                .font(.caption)
                .foregroundColor(.snilsTop)
                .padding(.top, Constants.padding)
            Text(Constants.subTitle)
                .font(.caption2)
                .foregroundColor(.snilsTop)
        }
    }
}
