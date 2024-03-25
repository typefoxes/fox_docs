//
//  ShowSnilsView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct ShowSnilsView: View {

    // MARK: - Properties

    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false

    let snils: SnilsModel

    // MARK: - Constants

    private enum Constants {
        static let headerTitle: String = "СНИЛС"
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack {
                HeaderShowView(
                    showAlert: $showAlert,
                    title: Constants.headerTitle,
                    deleteAction: deleteData,
                    presentationMode: presentationMode
                )
                SnilsView(
                    snils: snils,
                    copyAction: copyTapped,
                    shareAction: shareSnils()
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
        let copiedText = text.replacingOccurrences(of: " ", with: "")
        UIPasteboard.general.string = copiedText
        feedbackGenerator.impactOccurred()
    }

    private func deleteData() {
        modelContext.delete(snils)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func shareSnils() -> String {
        let number = snils.number
        let name = snils.name
        let date = snils.dateAndPlace
        let gender = snils.sex

        let cardData = "Номер СНИЛС: \(number)\nИмя: \(name)\nДата рождения и город: \(date)\nПол: \(gender)"

        return cardData
    }
}
