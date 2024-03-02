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
                AddButtonView(saveAction: saveData, presentationMode: presentationMode)
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
                        DriveField(title: "1. Фамилия РУС", placeHolder: "XXXX", onChange: false, changeType: .none, text: $surname, keyboardType: .default)
                        DriveField(title: "1. Фамилия АНГЛ", placeHolder: "XXXX", onChange: false, changeType: .none, text: $surnameEng, keyboardType: .default)
                        DriveField(title: "2. Имя Отчество РУС", placeHolder: "XXXX XXXX", onChange: false, changeType: .none, text: $name, keyboardType: .default)
                        DriveField(title: "2. Имя Отчество АНГЛ", placeHolder: "XXXX XXXX", onChange: false, changeType: .none, text: $nameEng, keyboardType: .default)
                        DriveField(title: "3. Дата рождения", placeHolder: "XX.XX.XXXX", onChange: true, changeType: .date, text: $dateOfBirth, keyboardType: .numberPad)
                        DriveField(title: "3a. Город рождения", placeHolder: "XXXXXXXX", onChange: false, changeType: .none, text: $cityOfBirth, keyboardType: .default)
                        DriveField(title: "4a. Дата выдачи", placeHolder: "XX.XX.XXXX", onChange: true, changeType: .date, text: $dateOfIssue, keyboardType: .numberPad)
                        DriveField(title: "4b. Окончание срока", placeHolder: "XX.XX.XXXX", onChange: true, changeType: .date, text: $dateOfExpire, keyboardType: .numberPad)
                        DriveField(title: "4c. Кем выдано", placeHolder: "XXXXXXXX XXX", onChange: false, changeType: .none, text: $authority, keyboardType: .default)
                        DriveField(title: "5. Номер", placeHolder: "XX XX XXXXXX", onChange: true, changeType: .number, text: $number, keyboardType: .numberPad)
                        DriveField(title: "8. Город выдачи", placeHolder: "XXXXXXXXXX", onChange: false, changeType: .none, text: $cityOfIssue, keyboardType: .default)

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
                                        .navigationBarItems(trailing: Button("Сохранить") {
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

struct DriveField: View {
    let title: String
    let placeHolder: String
    let onChange: Bool
    let changeType: onChange
    @Binding var text: String
    let keyboardType: UIKeyboardType

    var body: some View {
        HStack {
            HStack {
                Text(title)
                    .font(.system(.caption2, design: .rounded))
                    .fontWeight(.heavy)
            }
           HStack {
               TextField(placeHolder, text: $text)
                   .onChange(of: text, { oldValue, newValue in
                       if onChange {
                           switch changeType {
                               case .date: 
                                   text = newValue .dateFormateString(newValue)
                               case .none:
                                   text = newValue.uppercased()
                               case .number:
                                   text = formatNumber(newValue)
                           }

                       }
               })
                .keyboardType(keyboardType)
            }
        }
    }

    private func formatNumber(_ value: String) -> String {
        let formattedText = value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var finalText = ""
        var index = 0
        for character in formattedText {
            if index == 2 || index == 4 {
                finalText += " "
            }
            finalText.append(character)
            index += 1
        }
        return String(finalText.prefix(12))
    }
}

enum onChange {
    case none
    case date
    case number
}

