//
//  AddDriveLicensView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct ShowDriveLicensView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var showAlert = false

    let drive: DriveModel

    var body: some View {
        NavigationStack {
            VStack {
                HeaderShowView(showAlert: $showAlert, title: "", deleteAction: deleteData, presentationMode: presentationMode)
                DriveLicensBodyView(drive: drive, shareAction: shareDrive())
                Spacer(minLength: 0)
                BaseButtonView(title: .close, presentationMode: presentationMode)
            }
            .padding()
        }
    }

    private func deleteData() {
        modelContext.delete(drive)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func shareDrive() -> String {
        let nameRus = "\(drive.surname) \(drive.name)"
        let nameEng = "\(drive.surnameEng) \(drive.nameEng)"
        let dateOfBirth = drive.dateOfBirth
        let cityOfBirth = "\(drive.cityOfBirth) / \(drive.cityOfBirthEng)"
        let dateOfIssue = drive.dateOfIssue
        let dateOfExpire = drive.dateOfExpire
        let authority = drive.authority
        let number = drive.number
        let category = drive.category.map { String(describing: $0.rawValue) }.joined(separator: ", ")
        let cityOfIssue = drive.cityOfIssue


        let driveData = "ФИО РУС: \(nameRus)\nФИО АНГЛ: \(nameEng)\nДата рождения: \(dateOfBirth)\nГород рождения: \(cityOfBirth)\nДата получения: \(dateOfIssue)\nДата окончания срока: \(dateOfExpire)\nВыдан: \(authority)\nНомер: \(number)\nГород получения: \(cityOfIssue)\nКатегория: \(category)"

        return driveData
    }
}

#Preview {
    ShowDriveLicensView(drive: DriveModel(surname: "КОТИНА", surnameEng: "KOTINA", name: "ДАРЬЯ СЕРГЕЕВНА", nameEng: "DARIA SERGEEVNA", dateOfBirth: "02.04.1997", cityOfBirth: "МОСКВА", cityOfBirthEng: "MOSKVA", dateOfIssue: "23.07.2017", dateOfExpire: "23.07.2027", authority: "ГИБДД 7724", number: "77 33 124234", category: [.b, .b1, .m], cityOfIssue: "МОСКВА"))
}
