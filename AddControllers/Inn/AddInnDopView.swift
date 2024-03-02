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
                            case .number:
                                text = formatNumber(newValue)
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

struct AddInnMenu: View {
    let title: String
    let genders: [Sex]
    @Binding var selectedGender: Sex

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack {
                Menu {
                    ForEach(genders, id: \.self) { gender in
                        Button(action: { selectedGender = gender
                        }) {
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                } label: {
                    Text(selectedGender.rawValue)
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .underline()
                }
                Spacer()
            }
        }
    }
}
