//
//  AddCardViewController.swift
//  Fox Docs
//
//  Created by Fox on 11.02.2024.
//

import SwiftUI

struct AddCardViewController: View {

    private enum Constants {
        static let toolbarButton: String = "Следующий"
        static let padding: CGFloat = 50
    }

    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FocusState private var activeTF: ActiveKeyboardFields!

    @State private var name: String = .empty
    @State private var cvv: String = .empty
    @State private var type: String = .empty
    @State private var date: String = .empty
    @State private var number: String = .empty
    @State private var selectedBank: Bank = .noBank
    @State private var selectedType: BankType = .noType

    var body: some View {
        NavigationStack {
            VStack {
                AddCardBodyView(name: $name, cvv: $cvv, type: $type, date: $date, number: $number, selectedBank: $selectedBank, selectedType: $selectedType)
                    .padding(.top, Constants.padding)
                Spacer()
                AddButtonView(saveAction: saveData, presentationMode: presentationMode)
                    .disableWithOpacity(number.count != 19 || date.count != 5 || name.isEmpty || cvv.count != 3 || selectedType == .noType || selectedBank == .noBank)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    if activeTF != .cardHolderName {
                        Button(Constants.toolbarButton) {
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
