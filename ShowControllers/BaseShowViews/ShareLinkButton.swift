//
//  ShareLink.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

struct ShareLinkButton: View {
    var action: String
    var shareTitle: String

    var body: some View {
        ShareLink(item: action, preview: SharePreview(shareTitle, image: Image("fox"))) {
            Label("Поделиться", systemImage: "square.and.arrow.up")
                .foregroundColor(.secondary)
                .padding(.vertical, 12)
        }
    }
}
