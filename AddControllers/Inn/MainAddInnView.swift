//
//  InnDopView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 02.03.2024.
//

import SwiftUI

struct MainAddInnView: View {

    @Binding var number: String
    @Binding var name: String
    @Binding var dateOfBirth: String
    @Binding var placeOfBirth: String
    @Binding var selectedGender: Sex

    @Binding  var genders: [Sex]

    var body: some View {
        VStack() {
            Text("СВИДЕТЕЛЬСТВО").font(.caption).foregroundColor(.innFontTop).padding(.top, 10)
            Text("О ПОСТАНОВКЕ НА УЧЕТ В НАЛОГОВОМ ОРГАНЕ").font(.caption2).foregroundColor(.innFontTop)
            VStack() {
                HStack {
                    VStack {
                        AddInnField(title: "Номер", placeHolder: "XXXX XXXX XXXX", changeType: .number, text: $number, keyboardType: .numberPad)
                        AddInnField(title: "ФИО", placeHolder: "ABCD ABCD ABCD", changeType: .none, text: $name, keyboardType: .default)
                        AddInnField(title: "Дата рождения", placeHolder: "XX.XX.XXXX", changeType: .date, text: $dateOfBirth, keyboardType: .numberPad)
                        HStack {
                            AddInnMenu(title: "Пол", genders: genders, selectedGender: $selectedGender)
                            AddInnField(title: "Место рождения", placeHolder: "New York City...", changeType: .none, text: $placeOfBirth, keyboardType: .default)
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
