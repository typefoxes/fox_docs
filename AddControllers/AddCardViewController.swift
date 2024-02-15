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
    @State private var typeCard: [BankType] = [.noType, .masterCard, .mir, .visa, .unionPay, .others]
    @State private var banks: [Bank] = [.noBank, .sber, .alfa, .tinkoff, .tinkoffPlatinum, .ozon, .yandex, .vtb, .gazprom, .mkb, .raifazen]



    var body: some View {
        NavigationStack {
            VStack {
                CardView()
                    .padding(.top, 50)
                Spacer(minLength: 0)
                Button(action: {
                    saveData()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Label("Add Card", systemImage: "lock")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(.linearGradient(colors: [Color.blue, Color.sber], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                }
                .disableWithOpacity(number.count != 19 || date.count != 5 || name.isEmpty || cvv.count != 3 || selectedType == .noType || selectedBank == .noBank)
            }
            .padding()
            .toolbar(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    if activeTF != .cardHolderName {
                        Button("Next") {
                            switch activeTF {
                            case .cardNumber:
                                activeTF = .expirationDate
                            case .cardHolderName:
                                break
                            case .expirationDate:
                                activeTF = .cvv
                            case .cvv:
                                activeTF = .cardHolderName
                            case .none: break
                            }
                        }
                        .tint(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
        }
    }

    @ViewBuilder
    func CardView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.linearGradient(colors: [Color.green, Color.accentColor], startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack(spacing: 5) {
                TextField("XXXX XXXX XXXX XXXX", text: $number)
                    .onChange(of: number, { oldValue, newValue in
                        number = ""
                        let startIndex = oldValue.startIndex
                        for index in 0..<oldValue.count {
                            let stringIndex = oldValue.index(startIndex, offsetBy: index)
                            number += String(oldValue[stringIndex])

                            if (index + 1) % 5 == 0 && oldValue[stringIndex] != " " {
                                number.insert(" ", at: stringIndex)
                            }
                        }
                        if oldValue.last == " " {
                            number.removeLast()
                        }
                        number = String(number.prefix(19))
                    })
                    .padding(10)
                    .font(.title3)
                    .keyboardType(.numberPad)
                    .focused($activeTF, equals: .cardNumber)

                HStack(spacing: 12) {
                    TextField("MM/YY", text: $date)
                        .onChange(of: date, { oldValue, newValue in
                            date = oldValue.replacingOccurrences(of: "/", with: "")
                            if oldValue.count >= 2 {
                                let index = oldValue.index(oldValue.startIndex ,offsetBy: 2)
                                date.insert("/", at: index)
                            }
                            if oldValue.last == "/" {
                                date.removeLast()
                            }
                            date = String(date.prefix(5))
                        })
                        .focused($activeTF, equals: .expirationDate)
                        .keyboardType(.numberPad)

                    TextField("CVV", text: $cvv).onChange(of: cvv, { oldValue, newValue in
                        cvv = oldValue
                        cvv = String(cvv.prefix(3))
                    })
                    .frame(width: 35)
                    .focused($activeTF, equals: .cvv)
                    .keyboardType(.numberPad)
                }
                Spacer()
                TextField("CARDHOLDER NAME", text: $name)
                    .onChange(of: name, { oldValue, newValue in
                        name = oldValue.uppercased()
                    })
                    .focused($activeTF, equals: .cardHolderName)
                    .submitLabel(.done)

                HStack(spacing: 5) {
                    Menu {
                        ForEach(typeCard, id: \.self) { type in
                            Button(action: { selectedType = type
                            }) {
                                Text(type.rawValue).tag(type)
                            }
                        }
                    } label: {
                        Text(selectedType.rawValue)
                            .font(.body)
                            .foregroundColor(.white)
                            .underline()
                    }
                    .background(Color.clear)
                    .padding(10)
                    Spacer()
                    Menu {
                        ForEach(banks, id: \.self) { bank in
                            Button(action: { selectedBank = bank
                            }) {
                                Text(bank.rawValue).tag(bank)
                            }
                        }
                    } label: {
                        Text(selectedBank.rawValue)
                            .font(.body)
                            .foregroundColor(.white)
                            .underline()
                    }
                }
            }
            .padding(20)
            .environment(\.colorScheme, .dark)
            .tint(.white)

        }
        .frame(height: 200)
        .padding(20)
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
#Preview {
    AddCardViewController()
}
