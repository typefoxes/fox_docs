//
//  AddDriveView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct AddDriveView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var surname: String = ""
    @State private var surnameEng: String = ""
    @State private var name: String = ""
    @State private var nameEng: String = ""
    @State private var dateOfBirth: String = ""
    @State private var cityOfBirth: String = ""
    @State private var cityOfBirthEng: String = ""
    @State private var dateOfIssue: String = ""
    @State private var dateOfExpire: String = ""
    @State private var authority: String = ""
    @State private var number: String = ""
    @State private var cityOfIssue: String = ""

    @State private var selectedCategories: [DriveCategory] = []
    @State private var isShowingPicker = false

    var selectedCategoriesString: String {
        if selectedCategories.isEmpty {
            return "Выбрать"
        } else {
            return selectedCategories.map { $0.rawValue }.joined(separator: ", ")
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                AddDriveLicenceView(surname: $surname, surnameEng: $surnameEng, name: $name, nameEng: $nameEng, dateOfBirth: $dateOfBirth, cityOfBirth: $cityOfBirth, cityOfBirthEng: $cityOfBirthEng, dateOfIssue: $dateOfIssue, dateOfExpire: $dateOfExpire, authority: $authority, number: $number, cityOfIssue: $cityOfIssue, selectedCategories: $selectedCategories)
                Spacer()
                AddButtonView(saveAction: saveData, presentationMode: presentationMode)
                    .disableWithOpacity(surname.isEmpty || surnameEng.isEmpty || name.isEmpty || nameEng.isEmpty || dateOfBirth.isEmpty || cityOfBirth.isEmpty || cityOfBirthEng.isEmpty || dateOfIssue.isEmpty || dateOfExpire.isEmpty || authority.isEmpty || number.isEmpty)
            }
            .padding()
        }
    }

    private func saveData() {
        let drive = DriveModel(surname: surname, surnameEng: surnameEng, name: name, nameEng: nameEng, dateOfBirth: dateOfBirth, cityOfBirth: cityOfBirth, cityOfBirthEng: cityOfBirthEng, dateOfIssue: dateOfIssue, dateOfExpire: dateOfExpire, authority: authority, number: number, category: selectedCategories, cityOfIssue: cityOfIssue)
        modelContext.insert(drive)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    AddDriveView()
}
