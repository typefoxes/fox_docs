//
//  Test.swift
//  Fox Docs
//
//  Created by Fox on 13.02.2024.
//

import SwiftUI

struct AddPassportView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var fullName: String = ""
    @State private var seriaAndNumber: String = ""
    @State private var dateOfVidachy: String = ""
    @State private var whoGive: String = ""
    @State private var codePodrazdelenia: String = ""
    @State private var dateOfBirth: String = ""
    @State private var placeOfBirth: String = ""
    @State private var selectedSex: Sex = .none
    @State private var sex: [Sex] = [.female, .male]
    @State private var selectedDoc: TypeOfDocs = .passportRF

    @FocusState private var activeTF: ActiveKeyboardFieldsPassport!

    var body: some View {
        NavigationStack {
            VStack {
                CardView()
                Spacer(minLength: 0)
                Button(action: {
                    saveData()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Label("Добавить паспорт", systemImage: "lock.circle.fill")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                }
                .disableWithOpacity(fullName.isEmpty || seriaAndNumber.count != 11 || dateOfVidachy.count != 10 || whoGive.isEmpty || codePodrazdelenia.count != 7 || dateOfBirth.count != 10 || placeOfBirth.isEmpty || selectedSex == .none)
            }
            .padding()
            .toolbar(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    if activeTF != .placeOfBirth {
                        Button("Следующий") {
                            switch activeTF {
                            case .whoGive:
                                activeTF = .dateOfVidachy
                            case .placeOfBirth:
                                break
                            case .codePodrazdelenia:
                                activeTF = .seriaAndNumber
                            case .seriaAndNumber:
                                activeTF = .fullName
                            case .fullName:
                                activeTF = .dateOfBirth
                            case .none: break
                            case .dateOfVidachy:
                                activeTF = .codePodrazdelenia
                            case .dateOfBirth:
                                activeTF = .placeOfBirth
                            }
                        }
                        .tint(.black)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
        }
    }

    @ViewBuilder
    func CardView() -> some View {
        VStack() {
            Text("РОССИЙСКАЯ ФЕДЕРАЦИЯ")
                .foregroundColor(.passportText)
                .font(.caption)
            VStack() {
                VStack(spacing: 0) {
                    HStack() {
                        Text("Кем выдан")
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.top, 15)
                    TextField("МВД РОССИИ ПО Г.МОСКВА", text: $whoGive).onChange(of: whoGive, { oldValue, newValue in whoGive = oldValue.uppercased() })
                        .font(.title3)
                        .focused($activeTF, equals: .whoGive)
                    HStack() {
                        HStack() {
                            Text("Дата выдачи")
                                .font(.caption2)
                                .foregroundColor(.black)
                            Spacer()
                            Text("Код подразделения")
                                .font(.caption2)
                                .foregroundColor(.black)
                        }
                        .padding(.top, 10)
                    }
                    HStack() {
                        TextField("18.04.2017", text: $dateOfVidachy)
                            .onChange(of: dateOfVidachy, { oldValue, newValue in
                                dateOfVidachy = oldValue.replacingOccurrences(of: ".", with: "")
                                let nonDecimalCharacters = CharacterSet.decimalDigits.inverted
                                let updatedTextWithoutDots = dateOfVidachy.components(separatedBy: nonDecimalCharacters).joined()

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
                                dateOfVidachy = formattedDate
                                dateOfVidachy = String(dateOfVidachy.prefix(10))
                            })
                            .keyboardType(.numberPad)
                            .focused($activeTF, equals: .dateOfVidachy)

                        TextField("770-770", text: $codePodrazdelenia)
                            .onChange(of: codePodrazdelenia, { oldValue, newValue in
                                codePodrazdelenia = oldValue.replacingOccurrences(of: "-", with: "")
                                let nonDecimalCharacters = CharacterSet.decimalDigits.inverted
                                let updatedTextWithoutDots = codePodrazdelenia.components(separatedBy: nonDecimalCharacters).joined()
                                var formattedString = ""
                                var index = 0
                                for character in updatedTextWithoutDots {
                                    if index == 3 {
                                        formattedString.append("-")
                                    }
                                    formattedString.append(character)
                                    index += 1
                                }
                                codePodrazdelenia = formattedString
                                codePodrazdelenia = String(codePodrazdelenia.prefix(7))
                            })
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                            .focused($activeTF, equals: .codePodrazdelenia)
                    }
                    HStack() {
                        Text("Серия и номер")
                            .font(.caption2)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.top, 30)
                    TextField("4820 656466", text: $seriaAndNumber)
                        .onChange(of: seriaAndNumber, { oldValue, newValue in
                            seriaAndNumber = oldValue.replacingOccurrences(of: " ", with: "")
                            let nonDecimalCharacters = CharacterSet.decimalDigits.inverted
                            let updatedTextWithoutDots = seriaAndNumber.components(separatedBy: nonDecimalCharacters).joined()
                            var formattedString = ""
                            var index = 0
                            for character in updatedTextWithoutDots {
                                if index == 4 {
                                    formattedString.append(" ")
                                }
                                formattedString.append(character)
                                index += 1
                            }
                            seriaAndNumber = formattedString
                            seriaAndNumber = String(seriaAndNumber.prefix(11))
                        })
                        .font(.title2)
                        .bold()
                        .keyboardType(.numberPad)
                        .focused($activeTF, equals: .seriaAndNumber)
                }
            }
            .padding(10)
            .environment(\.colorScheme, .light)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.passportInside)
            }
            HStack() {
                VStack {
                    VStack() {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
                VStack {
                    VStack {
                        Color.gray.frame(height: 1 / UIScreen.main.scale)
                    }
                }
            }
            VStack(spacing: 0) {
                HStack(){
                    Image(.passportPhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 130)
                        .cornerRadius(10)

                    Spacer()
                    VStack(spacing: 0) {
                        HStack() {
                            Text("ФИО")
                                .font(.caption2)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 15)
                        TextField("Котина Дарья Сергеевна", text: $fullName)
                            .onChange(of: fullName, { oldValue, newValue in
                                fullName = oldValue.uppercased()
                            })
                            .font(.callout)
                            .focused($activeTF, equals: .fullName)
                        HStack() {
                            VStack(spacing: 0){
                                HStack() {
                                    Text("Пол")
                                        .font(.caption2)
                                        .foregroundColor(.black)
                                    Spacer()
                                    HStack() {
                                        Text("Дата рождения")
                                            .font(.caption2)
                                            .foregroundColor(.black)
                                    }
                                }
                                HStack() {               
                                    Menu {
                                        ForEach(sex, id: \.self) { sex in
                                            Button(action: { selectedSex = sex
                                            }) {
                                                Text(sex.rawValue).tag(sex)
                                            }
                                        }
                                } label: {
                                    Text(selectedSex.rawValue)
                                        .font(.callout)
                                        .foregroundColor(.secondary)
                                        .underline()
                                }

                                    TextField("02.04.1997", text: $dateOfBirth)
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
                                        .multilineTextAlignment(.trailing)
                                        .keyboardType(.numberPad)
                                        .focused($activeTF, equals: .dateOfBirth)
                                }
                            }
                        }.padding(.top, 15)
                        HStack() {
                            Text("Место рождения")
                                .font(.caption2)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 15)
                        TextField("г. Москва", text: $placeOfBirth)
                            .onChange(of: placeOfBirth, { oldValue, newValue in
                                placeOfBirth = oldValue.uppercased()
                            })
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                            .focused($activeTF, equals: .placeOfBirth)
                    }
                }
                VStack {}.frame(height: 40)
            }
            .padding(10)
            .environment(\.colorScheme, .light)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.passportInside)
            }
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.passport)
        }
    }

    private func saveData() {
        let passport = PassportModel(fullName: fullName, seriaAndNumber: seriaAndNumber, dateOfVidachy: dateOfVidachy, whoGive: whoGive, codePodrazdelenia: codePodrazdelenia, dateOfBirth: dateOfBirth, placeOfBirth: placeOfBirth, type: selectedDoc.rawValue, sex: selectedSex)
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
