//
//  AddInnDopView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 02.03.2024.
//

import SwiftUI

struct AddInnField: View {
    let title: String
    let placeHolder: String
    let changeType: onChangeAddView
    @Binding var text: String
    let keyboardType: UIKeyboardType

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack {
                TextField(placeHolder, text: $text)
                    .onChange(of: text, { oldValue, newValue in
                        switch changeType {
                            case .date:
                                text = newValue.dateFormateString(newValue)
                            case .none:
                                text = newValue.uppercased()
                            case .innNumber:
                                text = formatNumber(newValue)
                            case .cvv:
                                break
                            case .cardNumber:
                                break
                            case .snilsNumber:
                                break
                        }
                    })
                    .font(.footnote)
                    .keyboardType(keyboardType)

            }
        }
    }

    private func formatNumber(_ value: String) -> String {
        let cleanValue = value.replacingOccurrences(of: " ", with: "")
        let formattedValue = cleanValue.chunkFormatted(withChunkSize: 4, withSeparator: " ")
        return String(formattedValue.prefix(14))
    }
}
