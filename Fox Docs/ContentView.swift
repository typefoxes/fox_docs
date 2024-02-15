//
//  ContentView.swift
//  Fox Docs
//
//  Created by Fox on 11.02.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    @Query private var cards: [CardViewModel]
    @Query private var passports: [PassportModel]
    @Query private var snils: [SnilsModel]
    @Query private var passportInt: [PassportIntModel]
    @Query private var inn: [INNModel]
    @Query private var drive: [DriveModel]


    @State var showSheet = false
    @State var showAddCardView = false
    @State var showAddPassportView = false
    @State var showAddSnilsView = false
    @State var showAddPassportIntView = false
    @State var showAddInnView = false
    @State var showAddDriveView = false

    @State var selectedCard: CardViewModel? = nil
    @State var selectedPassport: PassportModel? = nil
    @State var selectedSnils: SnilsModel? = nil
    @State var selectedPass: PassportIntModel? = nil
    @State var selectedInn: INNModel? = nil
    @State var selectedDrive: DriveModel? = nil

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Карты").bold(true)) {
                        ForEach(0..<1, id: \.self) { index in
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(cards) { card in
                                        VStack(alignment: .leading) {
                                            Text(card.number)
                                                .foregroundColor(.white)
                                                .font(.title2)
                                            HStack() {
                                                HStack() {
                                                    Image(card.bank.rawValue)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(height: 35)
                                                    Spacer()
                                                }
                                                Spacer()
                                                HStack() {
                                                    Spacer()
                                                    Image(card.type.rawValue)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(height: 25)
                                                        .frame(alignment: .trailing)
                                                }
                                            }
                                            .padding(.top, 50)
                                            .padding(.horizontal, 0)
                                        }
                                        .padding()
                                        .background {
                                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                .fill(card.gradient)
                                        }
                                        .onTapGesture {
                                                selectedCard = card
                                            }
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                    }
                                }
                            }
                            .frame(height: 200)
                        }
                    }
                    Section(header: Text("Документы")) {
                        ForEach(1..<2, id: \.self) { index in
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(passports) { passport in
                                        VStack(alignment: .leading) {
                                            Text(passport.type)
                                                .foregroundColor(.white)
                                                .font(.title2)
                                            VStack {} .frame(height: 20)
                                            Text(passport.seriaAndNumber)
                                                .foregroundColor(.white)
                                                .font(.title2)
                                        }
                                        .padding(10)
                                        .onTapGesture {
                                            selectedPassport = passport
                                        }
                                        .background {
                                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                .fill(.linearGradient(colors: [Color.passport, Color.red], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        }
                                    }
                                    ForEach(snils) { snil in
                                        VStack(alignment: .leading) {
                                            Text(snil.type)
                                                .foregroundColor(.white)
                                                .font(.title2)
                                            VStack {} .frame(height: 20)
                                            Text(snil.number)
                                                .foregroundColor(.white)
                                                .font(.title2)
                                        }
                                        .padding(10)
                                        .onTapGesture {
                                            selectedSnils = snil
                                        }
                                        .background {
                                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                .fill(.linearGradient(colors: [Color.snils, Color.snilsHead], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        }
                                    }
                                    ForEach(passportInt) { pass in
                                        VStack(alignment: .leading) {
                                            Text(pass.type)
                                                .foregroundColor(.white)
                                                .font(.title2)
                                            VStack {} .frame(height: 20)
                                            Text(pass.number)
                                                .foregroundColor(.white)
                                                .font(.title2)
                                        }
                                        .padding(10)
                                        .onTapGesture {
                                            selectedPass = pass
                                        }
                                        .background {
                                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                .fill(.linearGradient(colors: [Color.passport, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        }
                                    }
                                    ForEach(inn) { inn in
                                        VStack(alignment: .leading) {
                                            Text(inn.type)
                                                .foregroundColor(.white)
                                                .font(.title2)
                                            VStack {} .frame(height: 20)
                                            Text(inn.number)
                                                .foregroundColor(.white)
                                                .font(.title2)
                                        }
                                        .padding(10)
                                        .onTapGesture {
                                            selectedInn = inn
                                        }
                                        .background {
                                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                .fill(.linearGradient(colors: [Color.passport, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        }
                                    }
                                    ForEach(drive) { drive in
                                        VStack(alignment: .leading) {
                                            Text(drive.type)
                                                .foregroundColor(.white)
                                                .font(.title2)
                                            VStack {} .frame(height: 20)
                                            Text(drive.number)
                                                .foregroundColor(.white)
                                                .font(.title2)
                                        }
                                        .padding(10)
                                        .onTapGesture {
                                            selectedDrive = drive
                                        }
                                        .background {
                                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                .fill(.linearGradient(colors: [Color.passport, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        }
                                    }
                                }
                            }
                            .frame(height: 200)
                        }
                    }
                }
                .sheet(item: $selectedPassport) { passport in
                    ShowPassportView(passport: passport)
                        }
                .sheet(item: $selectedCard) { card in
                    CardViewController(card: card)
                        }
                .sheet(item: $selectedSnils) { snils in
                    ShowSnilsView(snils: snils)
                        }
                .sheet(item: $selectedPass) { pass in
                    ShowPassportIntView(passport: pass)
                        }
                .sheet(item: $selectedInn) { inn in
                    ShowInnView(inn: inn)
                        }
                .sheet(item: $selectedDrive) { drive in
                    ShowDriveLicensView(drive: drive)
                        }
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            self.showSheet = true }) {
                                Text("+")
                                    .bold()
                                    .font(.system(.largeTitle,design:.rounded))
                            }
                            .actionSheet(isPresented: $showSheet, content: { sheet })
                            .sheet(isPresented: $showAddCardView) { AddCardViewController() }
                            .sheet(isPresented: $showAddSnilsView) { AddSnilsView() }
                            .sheet(isPresented: $showAddPassportView) { AddPassportView() }
                            .sheet(isPresented: $showAddPassportIntView) { AddIntPassportView() }
                            .sheet(isPresented: $showAddInnView) { AddInnView() }
                            .sheet(isPresented: $showAddDriveView) { AddDriveView() }
                    }
                }
            }
        }
    }

    private var sheet: ActionSheet {
        let action = ActionSheet(
            title: Text("Что добавить?"),
            message: nil,
            buttons: [
                .default(Text("Карта"), action: { showAddCardView = true }),
                .default(Text("Паспорт"), action: { showAddPassportView = true }),
                .default(Text("Права"), action: { showAddDriveView = true }),
                .default(Text("Загранник"), action: { showAddPassportIntView = true }),
                .default(Text("СНИЛС"), action: { showAddSnilsView = true }),
                .default(Text("ИНН"), action: { showAddInnView = true }),
                .cancel({ showSheet = false })
            ])
        return action
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [CardViewModel.self, PassportModel.self, SnilsModel.self, PassportIntModel.self, INNModel.self, DriveModel.self], inMemory: true)
}
