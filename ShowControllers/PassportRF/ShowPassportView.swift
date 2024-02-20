//
//  Test.swift
//  Fox Docs
//
//  Created by Fox on 13.02.2024.
//

import SwiftUI

struct ShowPassportView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var showAlert = false

    let passport: PassportModel

    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(showAlert: $showAlert, title: "Паспорт РФ", deleteAction: deleteData, presentationMode: presentationMode)

                PassportView(passport: passport, copyAction: copyTapped, shareAction: sharePassport(), shareTitle: makeShortName())
                Spacer()
                CloseButtonView(presentationMode: presentationMode)
            }
            .padding()
        }
    }

    private func copyTapped(text: String) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        UIPasteboard.general.string = text
        feedbackGenerator.impactOccurred()
    }

    private func sharePassport() -> String {
        let fullName = passport.fullName
        let seriaAndNumber = passport.seriaAndNumber
        let dateOfVidachy = passport.dateOfVidachy
        let whoGive = passport.whoGive
        let codePodrazdelenia = passport.codePodrazdelenia
        let dateOfBirth = passport.dateOfBirth
        let placeOfBirth = passport.placeOfBirth

        return "ФИО: \(fullName)\nСерия и номер: \(seriaAndNumber)\nДата выдачи: \(dateOfVidachy)\nКем выдан: \(whoGive)\nКод подразделения: \(codePodrazdelenia)\nДата рождения: \(dateOfBirth)\nМесто рождения: \(placeOfBirth)"
    }

    private func deleteData() {
        withAnimation {
            modelContext.delete(passport)
            do {
                try modelContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func makeShortName() -> String {
        let nameComponents = passport.fullName.components(separatedBy: " ")
        var shortName = "Паспорт РФ "

        if let lastName = nameComponents.first {
            shortName += "\(lastName) "
        }

        for i in 1..<nameComponents.count {
            if let firstCharacter = nameComponents[i].first {
                shortName += "\(firstCharacter)."
            }
        }

        return shortName.trimmingCharacters(in: .whitespaces)
    }
}

struct ShowPassportView_Previews: PreviewProvider {
    static var previews: some View {
        ShowPassportView(passport: PassportModel(fullName: "Котина Дарья Сергеевна", seriaAndNumber: "1234 123456", dateOfVidachy: "12.12.2020", whoGive: "МВД РОССИИ ПО ГОР МОСКВЕ gkghbkhgv yugkyu yugku fhf uehf e euhfuwehf uehfuqwefhu uehfuhfy gkgkyu yugukygb yugkuy", codePodrazdelenia: "770-770", dateOfBirth: "12.12.2022", placeOfBirth: "г.Москва", type: "Паспорт", sex: .female))
    }
}
