//
//  CardView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 20.02.2024.
//

import SwiftUI

struct CardView: View {
    let card: CardViewModel
    var copyAction: (String) -> Void
    var shareAction: String
    
    var body: some View {
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
                        copyAction(card.number)
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
        ShareLink(item: shareAction, preview: SharePreview("Карта \(card.bank.rawValue)", image: Image("fox"))) {
            Label("Поделиться", systemImage:  "square.and.arrow.up")
                .foregroundColor(.secondary)
                .padding(.vertical, 12)
        }
    }
}
