//
//  AddCardBodyView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 03.03.2024.
//

import SwiftUI

struct AddCardBodyView: View {

    private enum Constants {
        static let numberPlaceholder: String = "XXXX XXXX XXXX XXXX"
        static let datePlaceholder: String = "MM/YY"
        static let cvvPlaceholder: String = "CVV"
        static let namePlaceholder: String = "CARDHOLDER NAME"
        static let padding: CGFloat = 20
        static let frameHeight: CGFloat = 200
        static let cornerRadius: CGFloat = 20
        static let spacing: CGFloat = 10
    }

    @FocusState private var activeTF: ActiveKeyboardFields!

    @Binding var name: String
    @Binding var cvv: String
    @Binding var type: String
    @Binding var date: String
    @Binding var number: String
    @Binding var selectedBank: Bank
    @Binding var selectedType: BankType
    private let typeCard = BankType.allCases
    private let banks = Bank.allCases

    var body: some View {
        VStack() {
            VStack {
                AddField(title: nil, placeHolder: Constants.numberPlaceholder, changeType: .cardNumber, text: $number, keyboardType: .numberPad, titlePosition: .none)
                    .font(.title3)
                    .focused($activeTF, equals: .cardNumber)
                HStack {
                    AddField(title: nil, placeHolder: Constants.datePlaceholder, changeType: .date, text: $date, keyboardType: .numberPad, titlePosition: .none)
                        .focused($activeTF, equals: .expirationDate)
                    AddField(title: nil, placeHolder: Constants.cvvPlaceholder, changeType: .cvv, text: $cvv, keyboardType: .numberPad, titlePosition: .none)
                        .frame(width: 35)
                        .focused($activeTF, equals: .cvv)
                }.padding(.top, Constants.spacing)
                AddField(title: nil, placeHolder: Constants.namePlaceholder, changeType: .none, text: $name, keyboardType: .default, titlePosition: .none)
                    .focused($activeTF, equals: .cardHolderName)
                    .padding(.top, Constants.spacing)
            }
            HStack {
                GenericMenu(title: nil, options: BankType.allCases, selection: $selectedType, content: { type in
                    Text(type.rawValue)
                }, spacer: true)
                Spacer()
                GenericMenu(title: nil, options: Bank.allCases, selection: $selectedBank, content: { bank in
                    Text(bank.rawValue)
                }, spacer: false)
            }.padding(.top, Constants.spacing)
        }
        .padding(Constants.padding)
        .frame(height: Constants.frameHeight)
        .environment(\.colorScheme, .dark)
        .tint(.white)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
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
}

