//
//  InnDopView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 02.03.2024.
//

import SwiftUI
/// Эта структура представляет собой SwiftUI-представление для формы ввода данных INNModel.
struct AddInnBodyView: View {

    /// - Binding: Связанные свойства для отображения и изменения данных формы.
    @Binding var number: String
    @Binding var name: String
    @Binding var dateOfBirth: String
    @Binding var placeOfBirth: String
    @Binding var selectedGender: Sex
    @Binding  var genders: [Sex]

    /// Основное содержимое представления, состоящее из заголовка и полей формы.
    var body: some View {
        VStack() {
            Text("СВИДЕТЕЛЬСТВО").font(.caption).foregroundColor(.innFontTop).padding(.top, 10)
            Text("О ПОСТАНОВКЕ НА УЧЕТ В НАЛОГОВОМ ОРГАНЕ").font(.caption2).foregroundColor(.innFontTop)
            VStack() {
                HStack {
                    VStack {
                        /// AddField: Представление для отображения поля ввода с заголовком, плейсхолдером, текстом и клавиатурой.
                        AddField(title: "Номер", placeHolder: "XXXX XXXX XXXX", changeType: .innNumber, text: $number, keyboardType: .numberPad, titlePosition: .vertical)
                        AddField(title: "ФИО", placeHolder: "ABCD ABCD ABCD", changeType: .none, text: $name, keyboardType: .default, titlePosition: .vertical)
                        AddField(title: "Дата рождения", placeHolder: "XX.XX.XXXX", changeType: .fullDate, text: $dateOfBirth, keyboardType: .numberPad, titlePosition: .vertical)
                        HStack {
                            /// GenericMenu: Представление для отображения выпадающего меню с доступными полами.
                            GenericMenu(title: "Пол", options: genders, selection: $selectedGender, content: { gender in
                                Text(gender.rawValue)
                            }, spacer: true)
                            AddField(title: "Место рождения", placeHolder: "New York City...", changeType: .none, text: $placeOfBirth, keyboardType: .default, titlePosition: .vertical)
                        }.padding(.top, 10)
                    }.padding(20)
                    Image(.herbInn)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .tint(.innFontInside)
                }
                .padding(.top, 10)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.innInside)
                }
            }
        }
        .environment(\.colorScheme, .light)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.innTop)
        }
    }
}
