//
//  Test.swift
//  Fox Docs
//
//  Created by Fox on 13.02.2024.
//

import SwiftUI

struct ShowPassportView: View {
    // MARK: - Properties

    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false

    let passport: PassportModel

    // MARK: - Constants

    private enum Constants {
        static let title: String = "Паспорт РФ"
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack {
                HeaderShowView(
                    showAlert: $showAlert,
                    title: Constants.title,
                    deleteAction: deleteData,
                    presentationMode: presentationMode
                )

                PassportView(
                    passport: passport,
                    copyAction: copyTapped,
                    shareAction: sharePassport(),
                    shareTitle: makeShortName()
                )
                .environment(
                    \.colorScheme,
                     .light
                )
                Spacer()
                BaseButtonView(
                    title: .close,
                    presentationMode: presentationMode
                )
            }
            .padding()
        }
    }

    // MARK: - Private functions

    private func copyTapped(text: String) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        UIPasteboard.general.string = text
        feedbackGenerator.impactOccurred()
    }

    private func sharePassport() -> String {
        let fullName = passport.fullName
        let seriaAndNumber = passport.seriaAndNumber
        let dateOfVidachy = passport.dateOfVidachy
        let whoGive = passport.whoGive
        let codePodrazdelenia = passport.codePodrazdelenia
        let dateOfBirth = passport.dateOfBirth
        let placeOfBirth = passport.placeOfBirth

        return "ФИО: \(fullName)\nСерия и номер: \(seriaAndNumber)\nДата выдачи: \(dateOfVidachy)\nКем выдан: \(whoGive)\nКод подразделения: \(codePodrazdelenia)\nДата рождения: \(dateOfBirth)\nМесто рождения: \(placeOfBirth)"
    }

    private func deleteData() {
        withAnimation {
            modelContext.delete(passport)
            do {
                try modelContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func makeShortName() -> String {
        let nameComponents = passport.fullName.components(separatedBy: " ")
        var shortName = Constants.title

        if let lastName = nameComponents.first {
            shortName += " \(lastName) "
        }

        for i in 1..<nameComponents.count {
            if let firstCharacter = nameComponents[i].first {
                shortName += "\(firstCharacter)."
            }
        }

        return shortName.trimmingCharacters(in: .whitespaces)
    }
}
