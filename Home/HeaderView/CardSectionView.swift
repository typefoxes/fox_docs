//
//  CardSectionView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//
import SwiftData
import SwiftUI

struct CardSectionView: View {
    @State private var selectedCard: CardViewModel?
    @Query private var cards: [CardViewModel]

    var body: some View {
        Section(header: Text("Карты").bold()) {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(cards) { card in
                        CardHomeView(card: card)
                            .onTapGesture {
                                selectedCard = card
                            }
                    }
                }
            }
            .frame(height: 200)
        }
        .sheet(item: $selectedCard) { card in
            CardViewController(card: card)
        }
    }
}

struct CardHomeView: View {
    let card: CardViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(card.number)
                .foregroundColor(.white)
                .font(.title2)

            HStack {
                Image(card.bank.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 35)
                    .padding(.trailing)
                Spacer()
                Image(card.type.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 25)
            }
            .padding(.top, 50)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(card.gradient)
        )
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}
#Preview {
    CardSectionView()
        .modelContainer(for: [CardViewModel.self], inMemory: true)
}
