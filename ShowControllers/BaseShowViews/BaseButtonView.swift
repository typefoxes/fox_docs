//
//  AddButtonView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 24.02.2024.
//

import SwiftUI


/// Структура AddButtonView представляет собой представление кнопки для сохранения данных.
///
/// - Parameters:
///  - title: Название кнопки
///  - saveAction: Замыкание, которое будет вызвано при нажатии на кнопку сохранения.
///  - presentationMode: Привязка к режиму презентации, используется для закрытия текущего представления.

struct BaseButtonView: View {
    var title: TitleButton
    var saveAction: (() -> Void)?
    var presentationMode: Binding<PresentationMode>

    var body: some View {
        Button(action: {
            if let action = saveAction {
                action()
            }
            presentationMode.wrappedValue.dismiss()
        }) {
            Text(title.rawValue)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.linearGradient(colors: [Color.blue, Color.sber], startPoint: .topLeading, endPoint: .bottomTrailing))
                }
        }
    }
}

