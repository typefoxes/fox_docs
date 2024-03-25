//
//  ShareLink.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

struct ShareLinkButton: View {

    // MARK: - Constants

    private enum Constants {
        static let imageName: String = "fox"
        static let shareLinkLabel: String = "Поделиться"
        static let shareLinkImage: String = "square.and.arrow.up"
        static let verticalPadding: CGFloat = 12
    }

    // MARK: - Properties

    var action: String
    var shareTitle: String

    // MARK: - Body

    var body: some View {
        ShareLink(
            item: action,
            preview: SharePreview(
                shareTitle,
                image: Image(
                    Constants.imageName
                )
            )
        ){
            Label(
                Constants.shareLinkLabel,
                systemImage: Constants.shareLinkImage
            )
                .foregroundColor(.gray)
                .padding(.vertical, Constants.verticalPadding)
        }
    }
}
