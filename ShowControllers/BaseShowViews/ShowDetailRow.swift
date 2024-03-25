//
//  ShowDetailRow.swift
//  Fox Docs
//
//  Created by Дарья Котина on 05.03.2024.
//

import SwiftUI

struct DetailRow: View {

    // MARK: - Constants

    private enum Constants {
        static let copyImage: Image = Image("CopyImage")
        static let copyImageHeight: CGFloat = 15
        static let padding: CGFloat = 10
    }

    // MARK: - Properties

    let title: String
    let value: String
    let position: TitlePositions
    let textColor: Color
    var action: (() -> Void)? = nil

    // MARK: - Body

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

    // MARK: - Private functions

   private func titleBuilder() -> some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    private func valueBuilder() -> some View {
        HStack {
            Text(value)
                .font(.caption)
                .foregroundColor(textColor)
            if let action = action {
                Button(action: action) {
                    Constants.copyImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: Constants.copyImageHeight)
                        .tint(textColor)
                }
            }
            Spacer()
        }
    }
}
