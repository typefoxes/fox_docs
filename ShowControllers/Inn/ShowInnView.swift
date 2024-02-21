//
//  ShowInnView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct ShowInnView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var showAlert = false

    let inn: INNModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderShowView(showAlert: $showAlert, title: "ИНН", deleteAction: deleteData, presentationMode: presentationMode)
                InnView(inn: inn, copyAction: copyTapped, shareAction: shareInn())
                Spacer()
                CloseButtonView(presentationMode: presentationMode)
            }
            .padding()
        }
    }

    private func copyTapped(text: String) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        let copiedText = text.replacingOccurrences(of: " ", with: "")
        UIPasteboard.general.string = copiedText
        feedbackGenerator.impactOccurred()
    }

    private func deleteData() {
        modelContext.delete(inn)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func shareInn() -> String {
        let number = inn.number
        let name = inn.name
        let date = inn.dateOfBirth
        let gender = inn.gender
        let placeOfBirth = inn.placeOfBirth

        let cardData = "Номер ИНН: \(number)\nИмя: \(name)\nДата рождения: \(date)\nПол: \(gender)\n Место рождения: \(placeOfBirth)"

        return cardData
    }
}

#Preview {
    ShowInnView(inn: INNModel(number: "1324 1234 1272", name: "КОТИНА ДАРЬЯ СЕРГЕЕВНА", gender: .female, dateOfBirth: "02.04.1997", placeOfBirth: "МОСКВА"))
}
