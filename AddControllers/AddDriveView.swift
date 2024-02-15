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
                CardView()
                Spacer(minLength: 0)
                Button(action: {
                    saveData()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Label("Сохранить", systemImage: "")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(.linearGradient(colors: [Color.orange, Color.red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                }
            }
            .padding()
        }
    }

    @ViewBuilder
    func CardView() -> some View {
        VStack {
            VStack {
                Text("ВОДИТЕЛЬСКОЕ УДОСТОВЕРЕНИЕ")
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.heavy)
                VStack {
                    VStack {
                        HStack {
                            Text("1. Фамилия РУС").foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                TextField("XXXX", text: $surname)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("1. Фамилия АНГЛ").foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                TextField("XXXX", text: $surnameEng)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("2. Имя Отчество РУС").foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                TextField("XXXX XXXX", text: $name)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("2. Имя Отчество АНГЛ").foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                TextField("XXXX XXXX", text: $nameEng)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("3. Дата рождения").foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                TextField("XX.XX.XXXX", text: $dateOfBirth)
                                    .onChange(of: dateOfBirth, { oldValue, newValue in
                                        dateOfBirth = oldValue.replacingOccurrences(of: ".", with: "")
                                        let nonDecimalCharacters = CharacterSet.decimalDigits.inverted
                                        let updatedTextWithoutDots = dateOfBirth.components(separatedBy: nonDecimalCharacters).joined()

                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "ddMMyyyy"
                                        var formattedDate = ""
                                        var index = 0

                                        for character in updatedTextWithoutDots {
                                            if index == 2 || index == 4 {
                                                formattedDate.append(".")
                                            }

                                            formattedDate.append(character)
                                            index += 1
                                        }
                                        dateOfBirth = formattedDate
                                        dateOfBirth = String(dateOfBirth.prefix(10))
                                    })
                                    .multilineTextAlignment(.leading)
                                    .keyboardType(.numberPad)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("3a. Город рождения").foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            TextField("XXXXXXXX", text: $dateOfBirth)
                            Spacer()
                        }
                        HStack {
                            Text("4a. Дата выдачи")
                                .foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                TextField("XX.XX.XXXX", text: $dateOfIssue)
                                    .onChange(of: dateOfIssue, { oldValue, newValue in
                                        dateOfIssue = oldValue.replacingOccurrences(of: ".", with: "")
                                        let nonDecimalCharacters = CharacterSet.decimalDigits.inverted
                                        let updatedTextWithoutDots = dateOfIssue.components(separatedBy: nonDecimalCharacters).joined()

                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "ddMMyyyy"
                                        var formattedDate = ""
                                        var index = 0

                                        for character in updatedTextWithoutDots {
                                            if index == 2 || index == 4 {
                                                formattedDate.append(".")
                                            }

                                            formattedDate.append(character)
                                            index += 1
                                        }
                                        dateOfIssue = formattedDate
                                        dateOfIssue = String(dateOfIssue.prefix(10))
                                    })
                                    .multilineTextAlignment(.leading)
                                    .keyboardType(.numberPad)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("4b. Окончание срока")
                                .foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                TextField("XX.XX.XXXX", text: $dateOfExpire)
                                    .onChange(of: dateOfExpire, { oldValue, newValue in
                                        dateOfExpire = oldValue.replacingOccurrences(of: ".", with: "")
                                        let nonDecimalCharacters = CharacterSet.decimalDigits.inverted
                                        let updatedTextWithoutDots = dateOfExpire.components(separatedBy: nonDecimalCharacters).joined()

                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "ddMMyyyy"
                                        var formattedDate = ""
                                        var index = 0

                                        for character in updatedTextWithoutDots {
                                            if index == 2 || index == 4 {
                                                formattedDate.append(".")
                                            }

                                            formattedDate.append(character)
                                            index += 1
                                        }
                                        dateOfExpire = formattedDate
                                        dateOfExpire = String(dateOfExpire.prefix(10))
                                    })
                                    .multilineTextAlignment(.leading)
                                    .keyboardType(.numberPad)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("4c. Кем выдано")
                                .foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                TextField("XXXXXXXX XXX", text: $authority)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("5. Номер")
                                .foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                TextField("XX XX XXXXXX", text: $number)
                                    .onChange(of: number, { oldValue, newValue in
                                        let formattedText = oldValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                                        var finalText = ""
                                        var index = 0
                                        for character in formattedText {
                                            if index == 2 || index == 4 {
                                                finalText += " "
                                            }
                                            finalText.append(character)
                                            index += 1
                                        }
                                        if finalText.count > 12 {
                                            finalText = String(finalText.prefix(12))
                                        }
                                        number = finalText
                                    })
                                    .keyboardType(.numberPad)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("8. Город выдачи")
                                .foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                TextField("XXXXXXXXXX", text: $cityOfIssue)
                                Spacer()
                            }
                        }
                        HStack {
                            Text("9. Категория")
                                .foregroundColor(.white)
                                .font(.system(.caption2, design: .rounded))
                                .fontWeight(.heavy)
                            HStack {
                                VStack {
                                    Button(selectedCategoriesString) {
                                        self.isShowingPicker.toggle()
                                    }
                                    .font(.body)
                                    .foregroundColor(.secondary)

                                }
                                .sheet(isPresented: $isShowingPicker) {
                                    NavigationView {
                                        List {
                                            ForEach(DriveCategory.allCases, id: \.self) { category in
                                                Button(action: {
                                                    if self.selectedCategories.contains(category) {
                                                        self.selectedCategories.removeAll(where: { $0 == category })
                                                    } else {
                                                        self.selectedCategories.append(category)
                                                    }
                                                }) {
                                                    HStack {
                                                        Text(category.rawValue)
                                                        Spacer()
                                                        if self.selectedCategories.contains(category) {
                                                            Image(systemName: "checkmark")
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        .navigationBarItems(trailing: Button("Done") {
                                            self.isShowingPicker.toggle()
                                        })
                                    }
                                }
                                Spacer()
                            }
                        }
                    }.padding()
                }

                .background {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.linearGradient(colors: [Color.indigo, Color.cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.linearGradient(colors: [Color.blue, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing)) }
            .padding(5)
            .environment(\.colorScheme, .dark)
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

struct MultipleSelectionRow: View {
    var category: DriveCategory
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack {
                Text(category.rawValue)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
