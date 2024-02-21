//
//  DocsSectionView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI
import SwiftData

struct DocsSectionView: View {
    
    @Query private var passports: [PassportModel]
    @Query private var snils: [SnilsModel]
    @Query private var passportInt: [PassportIntModel]
    @Query private var inn: [INNModel]
    @Query private var drive: [DriveModel]
    
    @State var selectedPassport: PassportModel? = nil
    @State var selectedSnils: SnilsModel? = nil
    @State var selectedPass: PassportIntModel? = nil
    @State var selectedInn: INNModel? = nil
    @State var selectedDrive: DriveModel? = nil
    
    var body: some View {
        Section(header: Text("Документы")) {
            ForEach(0..<1, id: \.self) { index in
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
        .sheet(item: $selectedPassport) { passport in
            ShowPassportView(passport: passport)
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
    }
}
#Preview {
    DocsSectionView()
}
