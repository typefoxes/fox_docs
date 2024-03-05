//
//  AddTextFields.swift
//  Fox Docs
//
//  Created by Дарья Котина on 05.03.2024.
//

import SwiftUI

/// Структура для создания текстового поля ввода с дополнительными возможностями.
///
/// - Parameters:
///   - title: Заголовок текстового поля (необязательный).
///   - placeHolder: Плейсхолдер текстового поля.
///   - changeType: Обработчик изменений текста в текстовом поле.
///   - text: Ссылка на текущее значение текстового поля.
///   - keyboardType: Тип клавиатуры для текстового поля.
///   - titlePosition: Положение заголовка относительно текстового поля.
///
/// - Note: Тип `changeType` должен соответствовать протоколу `onChangeAddView`.
struct AddField: View {
    let title: String?
    let placeHolder: String
    let changeType: onChangeAddView
    @Binding var text: String
    let keyboardType: UIKeyboardType
    let titlePosition: TitlePositions

    /// Функция для создания текстового поля ввода.
    /// - Returns: Вью, содержащее текстовое поле ввода.
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
                            case .fullDate:
                                text = newValue.dateFormateString(newValue)
                        }
                    })
                    .keyboardType(keyboardType)
            }
        }
    }

/// Функция для создания заголовка текстового поля.
/// - Returns: Вью, содержащее заголовок текстового поля.
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

