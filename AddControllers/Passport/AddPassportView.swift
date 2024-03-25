//
//  AddPassportView.swift
//  Fox Docs
//
//  Created by Fox on 13.02.2024.
//

import SwiftUI

struct AddPassportView: View {

    // MARK: - Constants

    private enum Constants {
        static let passportData = "Паспортные данные"
        static let passportNo = "Серия и номер"
        static let dateOfIssue = "Дата выдачи"
        static let authority = "Кем выдан"
        static let codeAuthority = "Код подразделения"
        static let personalData = "Личные данные"
        static let name = "ФИО"
        static let dateOfBirth = "Дата рождения"
        static let placeOfBirth = "Место рождения"
        static let gender = "Пол"
        static let spacer: CGFloat = 50
        static let cornerRadius: CGFloat = 10
    }

    // MARK: - Private properties

    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var fullName: String = .empty
    @State private var number: String = .empty
    @State private var dateOfGive: Date = Date()
    @State private var whoGive: String = .empty
    @State private var codePodrazdelenia: String = .empty
    @State private var dateOfBirth: Date = Date()
    @State private var placeOfBirth: String = .empty
    @State private var selectedSex: Sex = .none
    @State private var sex: [Sex] = [.none, .female, .male]

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack {
                PassportAddView()
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
    }

    // MARK: - Private functions

    private func PassportAddView() -> some View {
        ZStack {
            List {
                Section(header: Text(Constants.passportData)) {
                    TextField(
                        Constants.passportNo,
                        text: $number
                    )
                        .onChange(of: number, { 
                            oldValue, newValue in
                            number = formatNumber(newValue)
                        })
                        .keyboardType(.numberPad)
                    DatePicker(
                        Constants.dateOfIssue,
                        selection: $dateOfGive,
                        displayedComponents: .date
                    )
                        .environment(\.locale, Locale(identifier: "ru_RU"))
                    TextField(
                        Constants.authority,
                        text: $whoGive
                    )
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    TextField(
                        Constants.codeAuthority,
                        text: $codePodrazdelenia
                    )
                        .onChange(of: codePodrazdelenia, { oldValue, newValue in
                            codePodrazdelenia = formatCode(newValue)
                        })
                        .keyboardType(.numberPad)
                }

                Section(header: Text(Constants.personalData)) {
                    TextField(
                        Constants.name,
                        text: $fullName
                    )
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    DatePicker(
                        Constants.dateOfBirth,
                        selection: $dateOfBirth,
                        displayedComponents: .date
                    )
                        .environment(\.locale, Locale(identifier: "ru_RU"))

                    TextField(
                        Constants.placeOfBirth,
                        text: $placeOfBirth
                    )
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    Picker(
                        Constants.gender,
                        selection: $selectedSex
                    ) {
                        ForEach(sex, id: \.self) { sex in
                            Text(sex.rawValue.capitalized).tag(sex)
                        }
                    }
                }
            }
        }
        .cornerRadius(Constants.cornerRadius)
    }

    private func formatNumber(_ value: String) -> String {
        var formattedValue = value.replacingOccurrences(of: " ", with: "")
        if formattedValue.count > 4 {
            formattedValue.insert(" ", at: formattedValue.index(formattedValue.startIndex, offsetBy: 4))
        }
        return String(formattedValue.prefix(11))
    }

    private func formatCode(_ value: String) -> String {
        var formattedValue = value.replacingOccurrences(of: "-", with: "")
        if formattedValue.count > 3 {
            formattedValue.insert("-", at: formattedValue.index(formattedValue.startIndex, offsetBy: 3))
        }
        return String(formattedValue.prefix(7))
    }

    private func saveData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let passport = PassportModel(
            fullName: fullName,
            seriaAndNumber: number,
            dateOfVidachy: dateFormatter.string(
                from: dateOfGive
            ),
            whoGive: whoGive,
            codePodrazdelenia: codePodrazdelenia,
            dateOfBirth: dateFormatter.string(from: dateOfBirth),
            placeOfBirth: placeOfBirth,
            type: "Паспорт РФ",
            sex: selectedSex
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
        return fullName.isEmpty || number.count != 11 || whoGive.isEmpty || codePodrazdelenia.count != 7 || placeOfBirth.isEmpty || selectedSex == .none
    }
}
