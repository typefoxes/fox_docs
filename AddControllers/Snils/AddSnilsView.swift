//
//  AddSnilsView.swift
//  Fox Docs
//
//  Created by Fox on 13.02.2024.
//

import SwiftUI

struct AddSnilsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var number: String = .empty
    @State private var name: String = .empty
    @State private var dateAndPlace: String = .empty
    @State private var selectedSex: Sex = .none

    var body: some View {
            VStack {
                AddSnilsBodyView(number: $number, name: $name, dateAndPlace: $dateAndPlace, selectedSex: $selectedSex)
                Spacer()
                AddButtonView(saveAction: saveData, presentationMode: presentationMode)
                    .disableWithOpacity(number.count != 14 || name.isEmpty || dateAndPlace.isEmpty || selectedSex == .none)
            }
            .padding()
    }
    
    private func saveData() {
        let snils = SnilsModel(number: number, name: name, dateAndPlace: dateAndPlace, sex: selectedSex)
        modelContext.insert(snils)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    AddSnilsView()
}

