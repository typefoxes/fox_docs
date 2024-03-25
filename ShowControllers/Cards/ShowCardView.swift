//
//  CardViewController.swift
//  Fox Docs
//
//  Created by Fox on 12.02.2024.
//

import SwiftUI

struct CardViewController: View {

    // MARK: - Properties

    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false
    let card: CardViewModel
    
    // MARK: - Body

    var body: some View {
            VStack {
                HeaderShowView(
                    showAlert: $showAlert,
                    title: "Банковская карта",
                    deleteAction: deleteData,
                    presentationMode: presentationMode
                )
                CardView(
                    card: card,
                    copyAction: copyTapped,
                    shareAction: shareCard()
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
        modelContext.delete(card)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func shareCard() -> String {
        let number = card.number
        let date = card.date
        let cvv = card.cvv
        let cardholder = card.name
        let bank = card.bank.rawValue
        let type = card.type
        
        let cardData = "Номер карты: \(number)\nДата окончания: \(date)\nCVV: \(cvv)\nВладелец: \(cardholder)\nБанк: \(bank)\nТип: \(type)"
        
        return cardData
    }
}
