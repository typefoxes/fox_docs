//
//  UniversalViews.swift
//  Fox Docs
//
//  Created by Дарья Котина on 03.03.2024.
//

import SwiftUI

struct GenericMenu<Option: Hashable, Content: View>: View {
    let title: String?
    let options: [Option]
    @Binding var selection: Option
    let content: (Option) -> Content
    var spacer: Bool

    var body: some View {
        VStack {
            HStack {
                Text(title ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack {
                Menu {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selection = option
                        }) {
                            content(option)
                                .tag(option)
                        }
                    }
                } label: {
                    content(selection)
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .underline()
                }
                if spacer {
                    Spacer()
                }
            }
        }
    }
}

struct AddField: View {
    let title: String?
    let placeHolder: String
    let changeType: onChangeAddView
    @Binding var text: String
    let keyboardType: UIKeyboardType
    let titlePosition: TitlePositions

    func textFieldBuilder() -> some View {
        HStack {
            HStack {
                TextField(placeHolder, text: $text)
                    .onChange(of: text, { oldValue, newValue in
                        switch changeType {
                            case .date:
                                text = String(newValue.chunkFormatted(withChunkSize: 2, withSeparator: "/").prefix(5))
                            case .none:
                                text = newValue.uppercased()
                            case .cardNumber:
                                text = String(newValue.chunkFormatted(withChunkSize: 4, withSeparator: " ").prefix(19))
                            case .cvv:
                                text = String(newValue.prefix(3))
                            case .snilsNumber:
                                text =  String(newValue.chunkFormatted(withChunkSize: 3, withSeparator: "-").prefix(14))
                            case .innNumber:
                                text = String(newValue.chunkFormatted(withChunkSize: 4, withSeparator: " ").prefix(14))
                        }
                    })
                    .keyboardType(keyboardType)
            }
        }
    }

    func titleBuilder() -> some View {
        HStack {
            Text(title ?? "")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
        }
    }

    var body: some View {
        switch titlePosition {
            case .vertical:
                VStack {
                    titleBuilder()
                    textFieldBuilder()
                }
            case .horizontal:
                HStack {
                    titleBuilder()
                    textFieldBuilder()
                }
            case .none:
                HStack {
                    textFieldBuilder()
                }
        }
    }
}

enum TitlePositions {
    case vertical
    case horizontal
    case none
}
