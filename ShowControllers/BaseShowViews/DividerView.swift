//
//  DividerView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 27.02.2024.
//

import SwiftUI
/// Структура для создания разделителя.
/// Вью, представляющее собой горизонтальную линию разделителя.
struct DividerView: View {
    var body: some View {
        HStack {
            ForEach(0..<10) { _ in
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
            }
        }
    }
}

