//
//  AddSnilsView.swift
//  Fox Docs
//
//  Created by Fox on 13.02.2024.
//

import SwiftUI

struct AddSnilsMainView: View {

    // MARK: - Private properties

    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var number: String = .empty
    @State private var name: String = .empty
    @State private var dateAndPlace: String = .empty
    @State private var selectedSex: Sex = .none

    // MARK: - Body
    var body: some View {
            VStack {
                AddSnilsBodyView(number: $number, name: $name, dateAndPlace: $dateAndPlace, selectedSex: $selectedSex)
                Spacer()
                BaseButtonView(title: .save, saveAction: saveData, presentationMode: presentationMode)
                    .disableWithOpacity(isDisabled())
            }
            .padding()
    }
    
    // MARK: - Private functions

    private func isDisabled() -> Bool {
        return number.count != 14 || name.isEmpty || dateAndPlace.isEmpty || selectedSex == .none
    }

    private func saveData() {
        let snils = SnilsModel(
            number: number,
            name: name,
            dateAndPlace: dateAndPlace,
            sex: selectedSex
        )
        modelContext.insert(snils)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}


