//
//  ShowSnilsView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct ShowSnilsView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var showAlert = false

    let snils: SnilsModel

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("СНИЛС")
                        .font(.title3)
                        .padding(.leading, 10)
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
                        })
                    }
                }
                .padding(.vertical, 20)
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
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(.linearGradient(colors: [Color.orange, Color.red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                }
            }
            .padding()
        }
    }

    @ViewBuilder
    func CardView() -> some View {
        VStack() {
            Text("СТРАХОВОЕ СВИДЕТЕЛЬСТВО").font(.caption).foregroundColor(.snilsTop).padding(.top, 10)
            Text("ОБЯЗАТЕЛЬНОГО ПЕНСИОННОГО СТРАХОВАНИЯ").font(.caption2).foregroundColor(.snilsTop)
            VStack() {
                VStack {
                    HStack {
                        Text("Номер")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    HStack {
                        Text(snils.number)
                            .font(.body)
                            .foregroundColor(.black)
                        Button {
                            copyTapped(text: snils.number)
                        } label: {
                            Image("CopyImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 15)
                                .tint(.secondary)
                        }
                        Spacer()
                    }
                    HStack {
                        Text("ФИО")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                    }.padding(.top, 10)
                    HStack {
                        Text(snils.name)
                            .font(.caption)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    HStack {
                        Text("Дата и место рождения")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                    }.padding(.top, 10)
                    HStack {
                        Text(snils.dateAndPlace)
                            .font(.caption)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    HStack {
                        Text("Пол")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                    }.padding(.top, 10)
                    HStack {
                        Text(snils.sex.rawValue)
                            .font(.caption)
                            .foregroundColor(.black)
                        Spacer()
                    }
                }.padding(20)
            }
            .padding(.top, 10)
            .environment(\.colorScheme, .light)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.snils)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.snilsHead)
        }
        ShareLink(item: shareSnils(),preview: SharePreview("СНИЛС", image: Image("fox"))) {
            Label("Поделиться", systemImage:  "square.and.arrow.up")
                .foregroundColor(.secondary)
                .padding(.vertical, 12)
        }
    }

    private func copyTapped(text: String) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        let copiedText = text.replacingOccurrences(of: " ", with: "")
        UIPasteboard.general.string = copiedText
        feedbackGenerator.impactOccurred()
    }

    private func deleteData() {
        modelContext.delete(snils)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func shareSnils() -> String {
        let number = snils.number
        let name = snils.name
        let date = snils.dateAndPlace
        let gender = snils.sex

        let cardData = "Номер СНИЛС: \(number)\nИмя: \(name)\nДата рождения и город: \(date)\nПол: \(gender)"

        return cardData
    }
}

#Preview {
    ShowSnilsView(snils: SnilsModel(number: "123-123-123 12", name: "КОТИНА ДАРЬЯ СЕРГЕЕВНА", dateAndPlace: "02 АПРЕЛЯ 1997 ГОДА МОСКВА", sex: .female, type: "СНИЛС"))
}
