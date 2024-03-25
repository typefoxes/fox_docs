//
//  CardSectionView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//
import SwiftData
import SwiftUI

struct CardSectionView: View {

    // MARK: - Private properties

    @State private var selectedCard: CardViewModel?
    @Query private var cards: [CardViewModel]

    private enum Constants {
        static let headerTitle: String = "Карты"
        static let frameHeight: CGFloat = 200
    }

    // MARK: - Body

    var body: some View {
        Section(header: Text(Constants.headerTitle).bold()) {
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
            .frame(height: Constants.frameHeight)
        }
        .sheet(item: $selectedCard) { card in
            CardViewController(card: card)
        }
    }
}

// MARK: - CardHomeView

struct CardHomeView: View {

    // MARK: - Private properties

    let card: CardViewModel

    private enum Constants {
        static let bankTitleFrame: CGFloat = 35
        static let bankTypeFrame: CGFloat = 25
        static let padding: CGFloat = 50
        static let subViewCornerRadius: CGFloat = 20
        static let mainViewCornerRadius: CGFloat = 10
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            Text(card.number)
                .foregroundColor(.white)
                .font(.title2)

            HStack {
                Image(card.bank.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constants.bankTitleFrame)
                    .padding(.trailing)
                Spacer()
                Image(card.type.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constants.bankTypeFrame)
            }
            .padding(.top, Constants.padding)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Constants.subViewCornerRadius)
                .fill(card.gradient)
        )
        .cornerRadius(Constants.mainViewCornerRadius)
        .foregroundColor(.white)
    }
}

// MARK: - Preview
#Preview {
    CardSectionView()
        .modelContainer(for: [CardViewModel.self], inMemory: true)
}
