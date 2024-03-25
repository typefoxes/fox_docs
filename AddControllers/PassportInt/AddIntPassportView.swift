//
//  AddIntPassportView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct AddIntPassportView: View {

    // MARK: - Constants

    private enum Constants {
        static let save = "Сохранить"
        static let passportData = "Паспортные данные"
        static let dateOfIssue = "Дата выдачи / Date of issue"
        static let dateOfexpire = "Окончания срока/ Date of expire"
        static let authority = "Орган выдачи / Authority"
        static let passportNo = "Номер паспорта / Passport No."
        static let personalData = "Личные данные"
        static let surname = "Фамилия / Surname"
        static let givenName = "Имя / Given name"
        static let dateOfBirth = "Дата рождения / Date of birth"
        static let placeOfBirth = "Место рождения / Place of birth"
        static let gender = "Пол"
        static let spacer: CGFloat = 50
    }

    // MARK: - Private properties

    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var surname: String = .empty
    @State private var givenName: String = .empty
    @State private var dateOfBirth: Date = Date()
    @State private var selectedGender: Gender = .none
    @State private var gender: [Gender] = [.none, .f, .m]
    @State private var placeOfBirth: String = .empty
    @State private var dateOfIssue: Date = Date()
    @State private var dateOfexpire: Date = Date()
    @State private var authority: String = .empty
    @State private var number: String = .empty

    // MARK: - Body

    var body: some View {
        VStack {
            PassportIntAddView()
            Spacer(minLength: Constants.spacer)
            BaseButtonView(
                title: .save,
                saveAction: saveData,
                presentationMode: presentationMode
            )
                .disableWithOpacity(isDisabled())
        }
        .padding()
    }

    // MARK: - Private functions

   private func PassportIntAddView() -> some View {
        ZStack {
            List {
                Section(header: Text(Constants.passportData)) {
                    DatePicker(
                        Constants.dateOfIssue,
                        selection: $dateOfIssue,
                        displayedComponents: .date
                    )
                    DatePicker(
                        Constants.dateOfexpire,
                        selection: $dateOfexpire,
                        displayedComponents: .date
                    )
                    TextField(
                        Constants.authority,
                        text: $authority
                    )
                    TextField(
                        Constants.passportNo,
                        text: $number
                    )
                        .onChange(of: number, { oldValue, newValue in
                            number = formatNumber(newValue)
                        })
                        .keyboardType(.numberPad)
                }

                Section(header: Text(Constants.personalData)) {
                    TextField(
                        Constants.surname,
                        text: $surname
                    )
                        .onChange(of: surname, { oldValue, newValue in
                            surname = oldValue.uppercased()
                        })
                    TextField(
                        Constants.givenName,
                        text: $givenName
                    )
                        .onChange(of: surname, { oldValue, newValue in
                            surname = oldValue.uppercased()
                        })
                    DatePicker(
                        Constants.dateOfBirth,
                        selection: $dateOfBirth,
                        displayedComponents: .date
                    )
                    TextField(
                        Constants.placeOfBirth,
                        text: $placeOfBirth
                    )
                        .onChange(of: placeOfBirth, { oldValue, newValue in
                            placeOfBirth = oldValue.uppercased()
                        })
                    Picker(
                        Constants.gender,
                        selection: $selectedGender
                    ) {
                        ForEach(gender, id: \.self) { 
                            sex in
                            Text(sex.rawValue.capitalized).tag(sex)
                        }
                    }
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
        let passport = PassportIntModel(
            surname: surname,
            givenName: givenName,
            dateOfBirth: dateFormatter.string(
                from: dateOfBirth
            ),
            gender: selectedGender,
            placeOfBirth: placeOfBirth,
            dateOfexpire: dateFormatter.string(
                from: dateOfexpire
            ),
            dateOfIssue: dateFormatter.string(
                from: dateOfIssue
            ),
            authority: authority,
            number: number
        )
        modelContext.insert(passport)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func isDisabled() -> Bool {
        return number.count != 10 || surname.isEmpty || selectedGender == .none || givenName.isEmpty || placeOfBirth.isEmpty || authority.isEmpty
    }
}

