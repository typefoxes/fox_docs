//
//  AddDriveView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct AddDriveMainView: View {

    // MARK: - Private properties

    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var surname: String = .empty
    @State private var surnameEng: String = .empty
    @State private var name: String = .empty
    @State private var nameEng: String = .empty
    @State private var dateOfBirth: String = .empty
    @State private var cityOfBirth: String = .empty
    @State private var cityOfBirthEng: String = .empty
    @State private var dateOfIssue: String = .empty
    @State private var dateOfExpire: String = .empty
    @State private var authority: String = .empty
    @State private var number: String = .empty
    @State private var cityOfIssue: String = .empty
    @State private var selectedCategories: [DriveCategory] = []

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack {
                AddDriveBodyView(
                    surname: $surname,
                    surnameEng: $surnameEng,
                    name: $name,
                    nameEng: $nameEng,
                    dateOfBirth: $dateOfBirth,
                    cityOfBirth: $cityOfBirth,
                    cityOfBirthEng: $cityOfBirthEng,
                    dateOfIssue: $dateOfIssue,
                    dateOfExpire: $dateOfExpire,
                    authority: $authority,
                    number: $number,
                    cityOfIssue: $cityOfIssue,
                    selectedCategories: $selectedCategories
                )
                Spacer()
                BaseButtonView(
                    title: .save,
                    saveAction: saveData,
                    presentationMode: presentationMode
                )
                    .disableWithOpacity(isDisabled())
            }
            .padding()
        }
    }

    // MARK: - Private functions

    private func isDisabled() -> Bool {
        return surname.isEmpty || surnameEng.isEmpty || name.isEmpty || nameEng.isEmpty || dateOfBirth.isEmpty || cityOfBirth.isEmpty || cityOfBirthEng.isEmpty || dateOfIssue.isEmpty || dateOfExpire.isEmpty || authority.isEmpty || number.isEmpty
    }

    private func saveData() {
        let drive = DriveModel(
            surname: surname,
            surnameEng: surnameEng,
            name: name,
            nameEng: nameEng,
            dateOfBirth: dateOfBirth,
            cityOfBirth: cityOfBirth,
            cityOfBirthEng: cityOfBirthEng,
            dateOfIssue: dateOfIssue,
            dateOfExpire: dateOfExpire,
            authority: authority,
            number: number,
            category: selectedCategories,
            cityOfIssue: cityOfIssue
        )
        modelContext.insert(drive)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}
