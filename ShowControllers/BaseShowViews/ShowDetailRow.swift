//
//  ShowDetailRow.swift
//  Fox Docs
//
//  Created by Дарья Котина on 05.03.2024.
//

import SwiftUI

struct DetailRow: View {

    private enum Constants {
        static let copyImage: Image = Image("CopyImage")
        static let copyImageHeight: CGFloat = 15
        static let padding: CGFloat = 10
    }

    let title: String
    let value: String
    let position: TitlePositions
    var action: (() -> Void)? = nil

    var body: some View {
        switch position {
            case .vertical:
                VStack {
                    titleBuilder()
                    valueBuilder()
                }
                .padding(.top, action == nil ? .zero : Constants.padding)
            case .horizontal:
                HStack {
                    titleBuilder()
                    valueBuilder()
                    Spacer()
                }
            case .none:
                valueBuilder()
        }
    }

    func titleBuilder() -> some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
        }
    }

    func valueBuilder() -> some View {
        HStack {
            Text(value)
                .font(.caption)
                .foregroundColor(.innFontInside)
            if let action = action {
                Button(action: action) {
                    Constants.copyImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: Constants.copyImageHeight)
                        .tint(.innFontInside)
                }
            }
            Spacer()
        }
    }
}
