//
//  AddIntPassportView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct ShowPassportIntView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var showAlert = false

    let passport: PassportIntModel

    var body: some View {
            VStack {
                HeaderShowView(showAlert: $showAlert, title: "Загранпаспорт", deleteAction: deleteData, presentationMode: presentationMode)
                InternationalPassportView(passport: passport, copyAction: copyTapped, shareAction: sharePassport())
                Spacer()
                CloseButtonView(presentationMode: presentationMode)
            }
            .padding()
    }

    private func copyTapped(text: String) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        let copiedText = text.replacingOccurrences(of: " ", with: "")
        UIPasteboard.general.string = copiedText
        feedbackGenerator.impactOccurred()
    }

    private func deleteData() {
        modelContext.delete(passport)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func sharePassport() -> String {
        let rusName = "\(passport.surname) \(passport.givenName)"
        let engName = "\(passport.surnameEng) \(passport.givenNameEng)"
        let dateOfBirth = passport.dateOfBirth
        let gender = passport.gender.rawValue
        let placeOfBirth = passport.placeOfBirth
        let dateOfexpire = passport.dateOfexpire
        let dateOfIssue = passport.dateOfIssue
        let authority = passport.authority
        let number = passport.number

        let passportData = "ФИО РУС: \(rusName)\nФИО АНГЛ: \(engName)\nДата рождения: \(dateOfBirth)\nПол: \(gender)\n Место рождения: \(placeOfBirth)\n Дата выдачи: \(dateOfIssue)\n Дата окончания срока действия: \(dateOfexpire)\n Орган, выдавший документ: \(authority)\n Номер: \(number)"

        return passportData
    }
}

#Preview {
    ShowPassportIntView(passport: PassportIntModel(surname: "ДОБРОВОЛЬСКАЯ", surnameEng: "DOBROVOLSKAYA", givenName: "ЕЛЕНА АЛЕКСАНДРОВНА", givenNameEng: "ELENA", dateOfBirth: "02.04.1997", gender: .f, placeOfBirth: "Г.МОСКВА", placeOfBirthEng: "RUSSIA", dateOfexpire: "02.06.2024", dateOfIssue: "25.05.2019", authority: "ФМС 77718", number: "73 5960757", type: "Загран"))
}
