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
                HStack {
                    Text("Паспорт РФ")
                        .font(.title3)
                        .bold()
                    Spacer()
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "trash.circle.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Вы хотите удалить этот документ?"),
                              primaryButton: .cancel(Text("Отменить")),
                              secondaryButton: .destructive(Text("Удалить")) {
                            deleteData()
                            presentationMode.wrappedValue.dismiss()
                        }
                        )
                    }
                }

                CardView()
                Spacer(minLength: 0)
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Label("Закрыть", systemImage: "xmark.circle.fill")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                }
            }
            .padding()
        }
    }

    @ViewBuilder
    func CardView() -> some View {
        VStack() {
            Text("РОССИЙСКАЯ ФЕДЕРАЦИЯ")
                .foregroundColor(.passportText)
                .font(.caption)
            VStack() {
                VStack(spacing: 1) {
                    HStack() {
                        Text("Кем выдан")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    HStack() {
                        Text(passport.whoGive)
                            .font(.caption2)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                            .bold()
                            .foregroundColor(.black)

                        Button {
                            copyTapped(text: passport.whoGive, spaces: true)
                        } label: {
                            Image("CopyImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 15)
                                .tint(.secondary)
                        }
                        Spacer()
                    }
                    HStack() {
                        VStack(spacing: 5){
                            HStack() {
                                Text("Дата выдачи")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(.top, 10)
                            HStack() {
                                Text(passport.dateOfVidachy)
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                        VStack(spacing: 5){
                            HStack() {
                                Text("Код подразделения")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(.top, 10)
                            HStack() {
                                Text(passport.codePodrazdelenia)
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                    }
                    HStack() {
                        Text(passport.seriaAndNumber)
                            .font(.title3)
                            .foregroundColor(.passport)
                            .bold()
                        Button {
                            copyTapped(text: passport.seriaAndNumber, spaces: false)
                        } label: {
                            Image("CopyImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 15)
                                .tint(.secondary)
                        }
                        .padding(.leading, 20)
                        Spacer()
                        Image(.herb)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                            .tint(.innFontInside)
                    }
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
            VStack() {
                HStack(){
                    Image(.passportPhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 130)
                        .cornerRadius(10)

                    Spacer()
                    VStack() {
                        HStack() {
                            Text("ФИО")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.top, 5)
                        HStack() {
                            Text(passport.fullName)
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .foregroundColor(.black)
                                .font(.caption2)
                            Spacer()
                        }
                        HStack() {
                            VStack(spacing: 5){
                                HStack() {
                                    Text("Пол")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                                HStack() {
                                    Text(passport.sex.rawValue)
                                        .font(.caption2)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                            }
                            VStack(spacing: 5){
                                HStack() {
                                    Text("Дата рождения")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                                HStack() {
                                    Text(passport.dateOfBirth)
                                        .font(.caption2)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 10)
                        HStack() {
                            Text("Место рождения")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        .padding(.top, 10)
                        HStack() {
                            Text(passport.placeOfBirth)
                                .font(.caption2)
                                .foregroundColor(.black)
                            Spacer()
                        }.padding(.top, 1)
                    }
                }
                ShareLink(item: sharePassport(),preview: SharePreview(makeShortName(), image: Image("fox"))) {
                    Label("Поделиться", systemImage:  "square.and.arrow.up")
                        .foregroundColor(.secondary)
                        .padding(.vertical, 12)
                }
            }
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.passportInside)
            }
            .environment(\.colorScheme, .light)
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.passport)
        }
    }

    private func copyTapped(text: String, spaces: Bool) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        let copiedText = spaces ? text : text.replacingOccurrences(of: " ", with: "")

        UIPasteboard.general.string = copiedText
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

        let passportData = "ФИО: \(fullName)\nСерия и номер: \(seriaAndNumber)\nДата выдачи: \(dateOfVidachy)\nКем выдан: \(whoGive)\nКод подразделения: \(codePodrazdelenia)\nДата рождения: \(dateOfBirth)\nМесто рождения: \(placeOfBirth)"

        return passportData
    }

    private func deleteData() {
        modelContext.delete(passport)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
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


#Preview {
    ShowPassportView(passport: PassportModel(fullName: "Котина Дарья Сергеевна", seriaAndNumber: "1234 123456", dateOfVidachy: "12.12.2020", whoGive: "МВД РОССИИ ПО ГОР МОСКВЕ gkghbkhgv yugkyu yugku fhf uehf e euhfuwehf uehfuqwefhu uehfuhfy gkgkyu yugukygb yugkuy", codePodrazdelenia: "770-770", dateOfBirth: "12.12.2022", placeOfBirth: "г.Москва", type: "Паспорт", sex: .female))
}

