//
//  GenericMenu.swift
//  Fox Docs
//
//  Created by Дарья Котина on 05.03.2024.
//

import SwiftUI

/// Структура для создания пользовательского меню в SwiftUI:
/// - Parameters:
///  - title: Заголовок меню (необязательный).
///  - option: Массив доступных для выбора вариантов.
///  - selection: Ссылка на текущий выбранный вариант.
///  - content: Клоужер, возвращающий представление для конкретного варианта.
///  - spacer: Булево значение, указывающее, нужно ли добавлять отступ после текущего выбранного варианта.
///
/// - Note: Тип `Option` должен соответствовать протоколу `Hashable`, а тип `Content` - протоколу `View`.
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
