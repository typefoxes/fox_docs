//
//  CardViewController.swift
//  Fox Docs
//
//  Created by Fox on 12.02.2024.
//

import SwiftUI

struct CardViewController: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showAlert = false
    
    let card: CardViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Просмотр карты")
                        .font(.title3)
                        .padding(.leading, 10)
                    Spacer()
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "trash.circle.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Вы хотите удалить этот документ?"),
                              primaryButton: .cancel(Text("Отменить")),
                              secondaryButton: .destructive(Text("Удалить")) {
                            deleteData()
                            presentationMode.wrappedValue.dismiss()
                        }
                        )
                    }
                }
                .padding(.vertical, 20)
                
                CardView()
                Spacer(minLength: 0)
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Label("Закрыть", systemImage: "xmark.circle.fill")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(.linearGradient(colors: [Color.orange, Color.red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    func CardView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(card.gradient)
            VStack(spacing: 5) {
                Spacer()
                HStack(spacing: 12) {
                    Text(card.number)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    Button {
                        copyTapped(text: card.number)
                    } label: {
                        Image("CopyImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                            .tint(.white)
                    }
                }
                Spacer()
                HStack(spacing: 12) {
                    HStack(spacing: 12) {
                        Text("Дата:")
                            .foregroundColor(.secondary)
                        Text(card.date)
                            .font(.body)
                            .bold()
                            .foregroundColor(.white)
                    }
                    Spacer()
                    HStack(spacing: 12) {
                        Text("cvv:")
                            .foregroundColor(.secondary)
                        Text(card.cvv)
                            .font(.body)
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                HStack() {
                    Text("Cardholder:")
                        .foregroundColor(.secondary)
                    Text(card.name)
                        .font(.body)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack() {
                    HStack(spacing: 5) {
                        Image("\(card.bank.rawValue)"+"Name")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 25)
                        Spacer()
                    }
                    Spacer()
                    HStack(spacing: 5) {
                        Spacer()
                        Image(card.type.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 35)
                    }
                    .padding(20)
                    .environment(\.colorScheme, .dark)
                    .tint(.white)
                    
                }
            }
            .padding(10)
        }
        .frame(height: 200)
        .padding(20)
        ShareLink(item: shareCard(),preview: SharePreview("Карта \(card.bank.rawValue)", image: Image("fox"))) {
            Label("Поделиться", systemImage:  "square.and.arrow.up")
                .foregroundColor(.secondary)
                .padding(.vertical, 12)
        }
    }
    
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

#Preview {
    CardViewController(card: CardViewModel(name: "Darya Kotina", number: "6666 6666 6666 6666", cvv: "123", type: .masterCard, date: "12/12", bank: .sber))
}
