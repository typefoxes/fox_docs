//
//  AddInnView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

/// Эта структура представляет собой представление SwiftUI для добавления нового объекта INNModel в базу данных
struct AddInnMainView: View {
    ///   - Environment(\.modelContext): Контекст для вставки и сохранения новых объектов в базу данных.
    @Environment(\.modelContext) private var modelContext
    ///   - Environment(\.presentationMode): Связываемое свойство, используемое для закрытия представления.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    ///   - State: Свойство обертки для хранения данных формы.
    @State private var number: String = .empty
    @State private var name: String = .empty
    @State private var dateOfBirth: String = .empty
    @State private var placeOfBirth: String = .empty
    @State private var selectedGender: Sex = .none

    /// - State: Свойство обертки для хранения списка доступных полов.
    @State private var genders: [Sex] = [.female, .male]

    /// Основное содержимое представления, состоящее из формы и кнопки "Сохранить".
    var body: some View {
        VStack {
            /// Форма для ввода данных INNModel.
            AddInnBodyView(number: $number, name: $name, dateOfBirth: $dateOfBirth, placeOfBirth: $placeOfBirth, selectedGender: $selectedGender, genders: $genders)
            Spacer()
            /// Кнопка "Сохранить", которая сохраняет данные формы в базу данных и закрывает представление.
            BaseButtonView(title: .save, saveAction: saveData, presentationMode: presentationMode)
                .disableWithOpacity(isFormValid())
        }
        .padding()
    }

    /// Проверяет правильность заполнения формы и возвращает true, если хотя бы одно поле не заполнено корректно.
    private func isFormValid() -> Bool {
        return number.count != 14 || name.isEmpty || dateOfBirth.count != 10 || placeOfBirth.isEmpty || selectedGender == .none
    }
    /// Сохраняет данные формы в базу данных и закрывает представление.
    private func saveData() {
        let inn = INNModel(number: number, name: name, gender: selectedGender, dateOfBirth: dateOfBirth, placeOfBirth: placeOfBirth)
        modelContext.insert(inn)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    AddInnMainView()
}

