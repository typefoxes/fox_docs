//
//  CardView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 20.02.2024.
//

import SwiftUI

struct CardView: View {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 20
        static let padding: CGFloat = 10
    }

    let card: CardViewModel
    var copyAction: (String) -> Void
    var shareAction: String
    
    var body: some View {
        ZStack {
            VStack {
                NumberSection(card: card, copyAction: copyAction)
                DateCVVSection(card: card)
                CardholderSection(card: card)
                BankTypeSection(card: card)
            }
            .padding(Constants.padding)
            .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(card.gradient))
            
        }
        ShareLinkButton(action: shareAction, shareTitle: "Карта \(card.bank.rawValue)")
    }
}

private struct NumberSection: View {

    private enum Constants {
        static let copyImage: Image = Image("CopyImage")
        static let copyImageHeight: CGFloat = 20
        static let padding: CGFloat = 10
    }

    let card: CardViewModel
    var copyAction: (String) -> Void
    
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

private struct DateCVVSection: View {

    private enum Constants {
        static let dateTitle: String = "Дата:"
        static let cvvTitle: String = "cvv:"
        static let padding: CGFloat = 12
    }

    let card: CardViewModel
    
    var body: some View {
        HStack(spacing: Constants.padding) {
            InfoTextCard(title: Constants.dateTitle, value: card.date)
            Spacer()
            InfoTextCard(title: Constants.cvvTitle, value: card.cvv)
        }
        .padding(.top, Constants.padding)
    }
}

private struct CardholderSection: View {

    private enum Constants {
        static let cardholderTitle: String = "Cardholder:"
        static let padding: CGFloat = 15
    }

    let card: CardViewModel
    
    var body: some View {
        HStack() {
            InfoTextCard(title: Constants.cardholderTitle, value: card.name)
            Spacer()
        }
        .padding(.top, Constants.padding)
    }
}

private struct BankTypeSection: View {

    private enum Constants {
        static let padding: CGFloat = 20
    }
    
    let card: CardViewModel
    
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

private struct InfoTextCard: View {
    
    private enum Constants {
        static let padding: CGFloat = 12
    }
    
    let title: String
    let value: String
    
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

private struct BankImage: View {
    
    private enum Constants {
        static let imageHeight: CGFloat = 25
    }
    
    let name: String
    
    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: Constants.imageHeight)
    }
}

private struct CardTypeImage: View {
    
    private enum Constants {
        static let imageHeight: CGFloat = 35
    }
    
    let name: String
    
    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: Constants.imageHeight)
    }
}

