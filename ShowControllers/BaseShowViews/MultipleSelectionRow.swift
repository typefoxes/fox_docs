//
//  MultipleSelectionRow.swift
//  Fox Docs
//
//  Created by Дарья Котина on 05.03.2024.
//

import SwiftUI
/// Структура для пользовательской строки для множественного выбора в списке.
/// Эта структура представляет собой одну строку в списке с множественным выбором. Она отображает имя категории и отметку, если категория выбрана.
///
///  - Parameters:
///   - category: Категория, представленная этой строкой.
///   - isSelected: Логическое значение, указывающее, выбрана ли категория.
///   - action: Замыкание, которое должно быть выполнено при нажатии на строку.
struct MultipleSelectionRow: View {

    // MARK: - Properties

    let category: DriveCategory
    let isSelected: Bool
    var action: () -> Void

    // MARK: - Body

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
