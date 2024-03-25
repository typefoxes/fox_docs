//
//  CardView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 20.02.2024.
//

import SwiftUI

struct CardView: View {
    
    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 20
        static let padding: CGFloat = 10
    }

    // MARK: - Properties

    let card: CardViewModel
    var copyAction: (String) -> Void
    var shareAction: String
    
    // MARK: - Body

    var body: some View {
        ZStack {
            VStack {
                NumberSection(
                    card: card,
                    copyAction: copyAction
                )
                DateCVVSection(card: card)
                CardholderSection(card: card)
                BankTypeSection(card: card)
            }
            .padding(Constants.padding)
            .background(
                RoundedRectangle(
                    cornerRadius: Constants.cornerRadius,
                    style: .continuous
                ).fill(
                    card.gradient
                )
            )
            
        }
        ShareLinkButton(
            action: shareAction,
            shareTitle: "Карта \(card.bank.rawValue)"
        )
    }
}

// MARK: - NumberSection
private struct NumberSection: View {

    // MARK: - Constants

    private enum Constants {
        static let copyImage: Image = Image("CopyImage")
        static let copyImageHeight: CGFloat = 20
        static let padding: CGFloat = 10
    }

    // MARK: - Properties

    let card: CardViewModel
    var copyAction: (String) -> Void
    
    // MARK: - Body

    var body: some View {
        HStack(spacing: Constants.padding) {
            Text(card.number)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Button {
                copyAction(card.number)
            } label: {
                Constants.copyImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constants.copyImageHeight)
                    .tint(.white)
            }
        }
    }
}

// MARK: - DateCVVSection
private struct DateCVVSection: View {

    // MARK: - Constants

    private enum Constants {
        static let dateTitle: String = "Дата:"
        static let cvvTitle: String = "cvv:"
        static let padding: CGFloat = 12
    }

    // MARK: - Properties

    let card: CardViewModel
    
    // MARK: - Body

    var body: some View {
        HStack(spacing: Constants.padding) {
            InfoTextCard(
                title: Constants.dateTitle,
                value: card.date
            )
            Spacer()
            InfoTextCard(
                title: Constants.cvvTitle,
                value: card.cvv
            )
        }
        .padding(.top, Constants.padding)
    }
}

// MARK: - CardholderSection
private struct CardholderSection: View {

    // MARK: - Constants

    private enum Constants {
        static let cardholderTitle: String = "Cardholder:"
        static let padding: CGFloat = 15
    }

    // MARK: - Properties

    let card: CardViewModel
    
    // MARK: - Body

    var body: some View {
        HStack() {
            InfoTextCard(
                title: Constants.cardholderTitle,
                value: card.name
            )
            Spacer()
        }
        .padding(.top, Constants.padding)
    }
}

// MARK: - BankTypeSection
private struct BankTypeSection: View {

    // MARK: - Constants

    private enum Constants {
        static let padding: CGFloat = 20
    }
    
    // MARK: - Properties

    let card: CardViewModel
    
    // MARK: - Body

    var body: some View {
        HStack {
            BankImage(name: "\(card.bank.rawValue)"+"Name")
            Spacer()
            CardTypeImage(name: card.type.rawValue)
                .padding(Constants.padding)
                .environment(\.colorScheme, .dark)
                .tint(.white)
        }
    }
}

// MARK: - InfoTextCard
private struct InfoTextCard: View {
    
    // MARK: - Constants

    private enum Constants {
        static let padding: CGFloat = 12
    }
    
    // MARK: - Properties

    let title: String
    let value: String
    
    // MARK: - Body

    var body: some View {
        HStack(spacing: Constants.padding) {
            Text(title)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
                .bold()
                .foregroundColor(.white)
        }
    }
}

// MARK: - BankImage
private struct BankImage: View {
    
    // MARK: - Constants

    private enum Constants {
        static let imageHeight: CGFloat = 25
    }
    
    // MARK: - Properties

    let name: String

    // MARK: - Body

    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: Constants.imageHeight)
    }
}

// MARK: - CardTypeImage
private struct CardTypeImage: View {
    
    // MARK: - Constants

    private enum Constants {
        static let imageHeight: CGFloat = 35
    }

    // MARK: - Properties

    let name: String
    
    // MARK: - Body

    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: Constants.imageHeight)
    }
}

