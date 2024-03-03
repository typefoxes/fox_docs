//
//  MenuView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 24.02.2024.
//

import SwiftUI

struct DropdownMenu<T: Hashable, V: View>: View {
    let title: String
    let options: [T]
    let onSelect: (T) -> Void

    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    onSelect(option)
                }) {
                    Text(String(describing: option))
                }
            }
        } label: {
            Text(title)
                .font(.body)
                .foregroundColor(.white)
                .underline()
        }
        .background(Color.clear)
        .padding(10)
    }
}
