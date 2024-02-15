//
//  ShowInnView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct ShowInnView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var showAlert = false

    let inn: INNModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("ИНН")
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
            Text("СВИДЕТЕЛЬСТВО").font(.caption).foregroundColor(.innFontTop).padding(.top, 10)
            Text("О ПОСТАНОВКЕ НА УЧЕТ В НАЛОГОВОМ ОРГАНЕ").font(.caption2).foregroundColor(.innFontTop)
            VStack() {
                HStack {
                    VStack {
                        /// Номер ИНН
                        HStack {
                            Text("Номер")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        HStack {
                            Text(inn.number)
                                .font(.body)
                                .foregroundColor(.innFontInside)
                            Button {
                                copyTapped(text: inn.number)
                            } label: {
                                Image("CopyImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 15)
                                    .tint(.innFontInside)
                            }
                            Spacer()
                        }
                        /// ФИО
                        HStack {
                            Text("ФИО")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.top, 10)
                        HStack {
                            Text(inn.name)
                                .font(.caption)
                                .foregroundColor(.innFontInside)
                            Spacer()
                        }
                        /// Дата рождения и пол
                        HStack {
                            Text("Дата рождения")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("Место рождения")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }.padding(.top, 10)
                        HStack {
                            Text(inn.dateOfBirth)
                                .font(.caption)
                                .foregroundColor(.innFontInside)
                            Spacer()
                            Text(inn.placeOfBirth)
                                .font(.caption)
                                .foregroundColor(.innFontInside)
                        }
                        HStack {
                            Text("Пол")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.top, 10)
                        HStack {
                            Text(inn.gender.rawValue)
                                .font(.caption)
                                .foregroundColor(.innFontInside)
                            Spacer()
                        }
                    }.padding(20)
                        Image(.herbInn)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .tint(.innFontInside)
                }
                .padding(.top, 10)
                .environment(\.colorScheme, .light)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.innInside)
                }
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.innTop)
        }
        ShareLink(item: shareInn(),preview: SharePreview("ИНН", image: Image("fox"))) {
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
        modelContext.delete(inn)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func shareInn() -> String {
        let number = inn.number
        let name = inn.name
        let date = inn.dateOfBirth
        let gender = inn.gender
        let placeOfBirth = inn.placeOfBirth

        let cardData = "Номер ИНН: \(number)\nИмя: \(name)\nДата рождения: \(date)\nПол: \(gender)\n Место рождения: \(placeOfBirth)"

        return cardData
    }
}

#Preview {
    ShowInnView(inn: INNModel(number: "1324 1234 1272", name: "КОТИНА ДАРЬЯ СЕРГЕЕВНА", gender: .female, dateOfBirth: "02.04.1997", placeOfBirth: "МОСКВА"))
}
