//
//  AddIntPassportView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct AddIntPassportView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var surname: String = ""
    @State private var givenName: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var selectedGender: Gender = .none
    @State private var gender: [Gender] = [.none, .f, .m]
    @State private var placeOfBirth: String = ""
    @State private var dateOfIssue: Date = Date()
    @State private var dateOfexpire: Date = Date()
    @State private var authority: String = ""
    @State private var number: String = ""

    var body: some View {
        VStack {
            PassportIntAddView()
            Spacer(minLength: 50)
            AddButtonView(saveAction: saveData, presentationMode: presentationMode)
                .disableWithOpacity(number.count != 10 || surname.isEmpty || selectedGender == .none || givenName.isEmpty || placeOfBirth.isEmpty || authority.isEmpty)
        }
        .padding()
    }

    func PassportIntAddView() -> some View {
        ZStack {
            List {
                Section(header: Text("Паспортные данные")) {
                    DatePicker("Дата выдачи / Date of issue", selection: $dateOfIssue, displayedComponents: .date)
                        .environment(\.locale, Locale(identifier: "ru_RU"))
                    DatePicker("Окончания срока/ Date of expire", selection: $dateOfexpire, displayedComponents: .date)
                        .environment(\.locale, Locale(identifier: "ru_RU"))

                    TextField("Орган выдачи / Authority", text: $authority)
                    TextField("Номер паспорта / Passport No.", text: $number)
                        .onChange(of: number, { oldValue, newValue in
                            number = formatNumber(newValue)
                        })
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Личные данные")) {
                    TextField("Фамилия / Surname", text: $surname)
                        .onChange(of: surname, { oldValue, newValue in
                            surname = oldValue.uppercased()
                        })
                    TextField("Имя / Given name", text: $givenName)
                        .onChange(of: surname, { oldValue, newValue in
                            surname = oldValue.uppercased()
                        })
                    DatePicker("Дата рождения / Date of birth", selection: $dateOfBirth, displayedComponents: .date)
                        .environment(\.locale, Locale(identifier: "ru_RU"))
                    TextField("Место рождения / Place of birth", text: $placeOfBirth)
                        .onChange(of: placeOfBirth, { oldValue, newValue in
                            placeOfBirth = oldValue.uppercased()
                        })
                }
            }
        }
        .cornerRadius(10)
    }

    private func formatNumber(_ value: String) -> String {
        var formattedValue = value.replacingOccurrences(of: " ", with: "")
        if formattedValue.count > 2 {
            formattedValue.insert(" ", at: formattedValue.index(formattedValue.startIndex, offsetBy: 2))
        }
        return String(formattedValue.prefix(10))
    }

    private func saveData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let passport = PassportIntModel(surname: surname, givenName: givenName, dateOfBirth: dateFormatter.string(from: dateOfBirth), gender: selectedGender, placeOfBirth: placeOfBirth, dateOfexpire: dateFormatter.string(from: dateOfexpire), dateOfIssue: dateFormatter.string(from: dateOfIssue), authority: authority, number: number)
        modelContext.insert(passport)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    AddIntPassportView()
}
