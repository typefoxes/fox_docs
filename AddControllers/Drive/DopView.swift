//
//  DopView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 02.03.2024.
//

import SwiftUI

struct DriveField: View {
    let title: String
    let placeHolder: String
    let changeType: onChangeAddView
    @Binding var text: String
    let keyboardType: UIKeyboardType

    var body: some View {
        HStack {
            HStack {
                Text(title)
                    .font(.system(.caption2, design: .rounded))
                    .fontWeight(.heavy)
            }
            HStack {
                TextField(placeHolder, text: $text)
                    .onChange(of: text, { oldValue, newValue in
                        switch changeType {
                            case .date:
                                text = newValue.dateFormateString(newValue)
                            case .none:
                                text = newValue.uppercased()
                            case .cardNumber:
                                text = formatNumber(newValue)
                            case .cvv:
                                break
                            case .snilsNumber:
                                break
                            case .innNumber:
                                break
                        }
                    })
                    .keyboardType(keyboardType)
            }
        }
    }

    private func formatNumber(_ value: String) -> String {
        let formattedText = value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var finalText = ""
        var index = 0
        for character in formattedText {
            if index == 2 || index == 4 {
                finalText += " "
            }
            finalText.append(character)
            index += 1
        }
        return String(finalText.prefix(12))
    }
}

struct MultipleSelectionRow: View {
    let category: DriveCategory
    let isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack {
                Text(category.rawValue)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
