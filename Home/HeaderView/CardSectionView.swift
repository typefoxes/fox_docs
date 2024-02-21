//
//  CardSectionView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//
import SwiftData
import SwiftUI

struct CardSectionView: View {
    @State var selectedCard: CardViewModel? = nil
    @Query private var cards: [CardViewModel]

    var body: some View {
        Section(header: Text("Карты").bold(true)) {
            ForEach(0..<1, id: \.self) { index in
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(cards) { card in
                            VStack(alignment: .leading) {
                                Text(card.number)
                                    .foregroundColor(.white)
                                    .font(.title2)
                                HStack() {
                                    HStack() {
                                        Image(card.bank.rawValue)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 35)
                                        Spacer()
                                    }
                                    Spacer()
                                    HStack() {
                                        Spacer()
                                        Image(card.type.rawValue)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 25)
                                            .frame(alignment: .trailing)
                                    }
                                }
                                .padding(.top, 50)
                                .padding(.horizontal, 0)
                            }
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(card.gradient)
                            }
                            .onTapGesture {
                                    selectedCard = card
                                }
                            .cornerRadius(10)
                            .foregroundColor(.white)
                        }
                    }
                }
                .frame(height: 200)
            }
        }
                        .sheet(item: $selectedCard) { card in
                            CardViewController(card: card)
                                }
    }
}
#Preview {
    CardSectionView()
        .modelContainer(for: [CardViewModel.self], inMemory: true)
}
