//
//  AddCardViewController.swift
//  Fox Docs
//
//  Created by Fox on 11.02.2024.
//

import SwiftUI

struct AddCardViewController: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FocusState private var activeTF: ActiveKeyboardFields!

    @State private var name: String = ""
    @State private var cvv: String = ""
    @State private var type: String = ""
    @State private var date: String = ""
    @State private var number: String = ""
    @State private var selectedBank: Bank = .noBank
    @State private var selectedType: BankType = .noType
    @State private var typeCard = BankType.allCases
    @State private var banks = Bank.allCases

    private var cardFields: some View {
        VStack(spacing: 12) {
            TextField("XXXX XXXX XXXX XXXX", text: $number)
                .onChange(of: number, { oldValue, newValue in
                    number = formatCardNumber(newValue)
                })
            .padding(10)
            .font(.title3)
            .keyboardType(.numberPad)
            .focused($activeTF, equals: .cardNumber)

            HStack(spacing: 12) {
                TextField("MM/YY", text: $date)
                    .onChange(of: date, { oldValue, newValue in
                        date = formatExpirationDate(newValue)
                    })
                .keyboardType(.numberPad)
                .focused($activeTF, equals: .expirationDate)

                TextField("CVV", text: $cvv).onChange(of: cvv, { oldValue, newValue in
                    cvv = String(cvv.prefix(3))
                })
                .frame(width: 35)
                .keyboardType(.numberPad)
                .focused($activeTF, equals: .cvv)
            }
        }
    }

    private var nameField: some View {
        TextField("CARDHOLDER NAME", text: $name)
        .autocapitalization(.allCharacters)
        .focused($activeTF, equals: .cardHolderName)
    }

    private var bankFields: some View {
        HStack {
            Picker("Card Type", selection: $selectedType) {
                ForEach(typeCard, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            Spacer()
            Picker("Bank", selection: $selectedBank) {
                ForEach(banks, id: \.self) { bank in
                    Text(bank.rawValue).tag(bank)
                }
            }
        }
    }

    private var cardBody: some View {
        VStack(spacing: 5) {
            cardFields
            Spacer()
            nameField
            bankFields
        }
        .padding(20)
        .frame(height: 200)
        .environment(\.colorScheme, .dark)
        .tint(.white)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.green, Color.accentColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .padding(20)
    }

    var body: some View {
        NavigationStack {
            VStack {
                cardBody
                    .padding(.top, 50)
                Spacer(minLength: 0)
                AddButtonView(saveAction: saveData, presentationMode: presentationMode)
                    .disableWithOpacity(number.count != 19 || date.count != 5 || name.isEmpty || cvv.count != 3 || selectedType == .noType || selectedBank == .noBank)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    if activeTF != .cardHolderName {
                        Button("Следующий") {
                            switch activeTF {
                            case .cardNumber:
                                activeTF = .expirationDate
                            case .cardHolderName:
                                break
                            case .expirationDate:
                                activeTF = .cvv
                            case .cvv:
                                activeTF = .cardHolderName
                            case .none:
                                break
                            }
                        }
                        .tint(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
        }
    }

    private func formatExpirationDate(_ value: String) -> String {
        var formattedValue = value.replacingOccurrences(of: "/", with: "")
        if formattedValue.count > 2 {
            formattedValue.insert("/", at: formattedValue.index(formattedValue.startIndex, offsetBy: 2))
        }
        return String(formattedValue.prefix(5))
    }

    private func formatCardNumber(_ value: String) -> String {
        let cleanValue = value.replacingOccurrences(of: " ", with: "")
        let formattedValue = cleanValue.chunkFormatted(withChunkSize: 4, withSeparator: " ")
        return String(formattedValue.prefix(19))
    }

    private func saveData() {
        let card = CardViewModel(name: name, number: number, cvv: cvv, type: BankType(rawValue: selectedType.rawValue) ?? .noType, date: date, bank: Bank(rawValue: selectedBank.rawValue) ?? .noBank)
        modelContext.insert(card)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct AddCardViewController_Previews: PreviewProvider {
    static var previews: some View {
        AddCardViewController()
    }
}
