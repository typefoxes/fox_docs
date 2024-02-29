//
//  AddPassportView.swift
//  Fox Docs
//
//  Created by Fox on 13.02.2024.
//

import SwiftUI

struct AddPassportView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var fullName: String = ""
    @State private var number: String = ""
    @State private var dateOfGive: Date = Date()
    @State private var whoGive: String = ""
    @State private var codePodrazdelenia: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var placeOfBirth: String = ""
    @State private var selectedSex: Sex = .none
    @State private var sex: [Sex] = [.none, .female, .male]

    var body: some View {
        NavigationStack {
            VStack {
                PassportAddView()
                Spacer(minLength: 50)
                AddButtonView(saveAction: saveData, presentationMode: presentationMode)
                .disableWithOpacity(fullName.isEmpty || number.count != 11 || whoGive.isEmpty || codePodrazdelenia.count != 7 || placeOfBirth.isEmpty || selectedSex == .none)
            }
            .padding()
        }
    }

    func PassportAddView() -> some View {
        ZStack {
            List {
                Section(header: Text("Паспортные данные")) {
                    TextField("Серия и номер", text: $number)
                        .onChange(of: number, { oldValue, newValue in
                            number = formatNumber(newValue)
                        })
                        .keyboardType(.numberPad)
                    DatePicker("Дата выдачи", selection: $dateOfGive, displayedComponents: .date)
                        .environment(\.locale, Locale(identifier: "ru_RU"))
                    TextField("Кем выдан", text: $whoGive)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    TextField("Код подразделения", text: $codePodrazdelenia)
                        .onChange(of: codePodrazdelenia, { oldValue, newValue in
                            codePodrazdelenia = formatCode(newValue)
                        })
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Личные данные")) {
                    TextField("ФИО", text: $fullName)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    DatePicker("Дата рождения", selection: $dateOfBirth, displayedComponents: .date)
                        .environment(\.locale, Locale(identifier: "ru_RU"))

                    TextField("Место рождения", text: $placeOfBirth)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    Picker("Пол", selection: $selectedSex) {
                        ForEach(sex, id: \.self) { sex in
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
        let passport = PassportModel(fullName: fullName, seriaAndNumber: number, dateOfVidachy: dateFormatter.string(from: dateOfGive), whoGive: whoGive, codePodrazdelenia: codePodrazdelenia, dateOfBirth: dateFormatter.string(from: dateOfBirth), placeOfBirth: placeOfBirth, type: "Паспорт РФ", sex: selectedSex)
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
    AddPassportView()
}
