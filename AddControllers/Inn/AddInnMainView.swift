//
//  AddInnView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct AddInnMainView: View {

    // MARK: - Private properties

    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var number: String = .empty
    @State private var name: String = .empty
    @State private var dateOfBirth: String = .empty
    @State private var placeOfBirth: String = .empty
    @State private var selectedGender: Sex = .none
    @State private var genders: [Sex] = [.female, .male]

    // MARK: - Body
    var body: some View {
        VStack {
            AddInnBodyView(
                number: $number,
                name: $name,
                dateOfBirth: $dateOfBirth,
                placeOfBirth: $placeOfBirth,
                selectedGender: $selectedGender,
                genders: $genders
            )
            Spacer()
            BaseButtonView(
                title: .save,
                saveAction: saveData,
                presentationMode: presentationMode
            )
                .disableWithOpacity(isFormValid())
        }
        .padding()
    }

    // MARK: - Private functions

    private func isFormValid() -> Bool {
        return number.count != 14 || name.isEmpty || dateOfBirth.count != 10 || placeOfBirth.isEmpty || selectedGender == .none
    }

    private func saveData() {
        let inn = INNModel(
            number: number,
            name: name,
            gender: selectedGender,
            dateOfBirth: dateOfBirth,
            placeOfBirth: placeOfBirth
        )
        modelContext.insert(inn)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

