//
//  DocumentWrapper.swift
//  Fox Docs
//
//  Created by Дарья Котина on 06.03.2024.
//

import SwiftUI

/// Структура, которая оборачивает документ в объект, содержащий уникальный идентификатор для использования в SwiftUI списках.
/// - Parameters:
///  - id: Уникальный идентификатор для объекта
///  - document: Объект, который оборачивается в этот класс.
struct DocumentWrapper: Identifiable {
    let id = UUID()
    let document: Any
}
