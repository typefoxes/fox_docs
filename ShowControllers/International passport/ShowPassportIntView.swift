//
//  AddIntPassportView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct ShowPassportIntView: View {

    // MARK: - Properties

    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false

    let passport: PassportIntModel

    // MARK: - Body

    var body: some View {
            VStack {
                HeaderShowView(
                    showAlert: $showAlert,
                    title: "Загранпаспорт",
                    deleteAction: deleteData,
                    presentationMode: presentationMode
                )
                InternationalPassportView(
                    passport: passport,
                    copyAction: copyTapped,
                    shareAction: sharePassport()
                )
                Spacer()
                BaseButtonView(
                    title: .close,
                    presentationMode: presentationMode
                )
            }
            .padding()
    }

    // MARK: - Private functions

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
        let dateOfBirth = passport.dateOfBirth
        let gender = passport.gender.rawValue
        let placeOfBirth = passport.placeOfBirth
        let dateOfexpire = passport.dateOfexpire
        let dateOfIssue = passport.dateOfIssue
        let authority = passport.authority
        let number = passport.number

        let passportData = "ФИО: \(rusName)\nДата рождения: \(dateOfBirth)\nПол: \(gender)\n Место рождения: \(placeOfBirth)\n Дата выдачи: \(dateOfIssue)\n Дата окончания срока действия: \(dateOfexpire)\n Орган, выдавший документ: \(authority)\n Номер: \(number)"

        return passportData
    }
}
