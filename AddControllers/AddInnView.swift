//
//  AddInnView.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import SwiftUI

struct AddInnView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var number: String = ""
    @State private var name: String = ""
    @State private var dateOfBirth: String = ""
    @State private var placeOfBirth: String = ""
    @State private var selectedGender: Sex = .none

    @State private var genders: [Sex] = [.female, .male]

    var body: some View {
        VStack {
            CardView()
            Spacer(minLength: 0)
            AddButtonView(saveAction: saveData, presentationMode: presentationMode)
                .disableWithOpacity(isFormValid())
        }
        .padding()
    }

    private struct CardTextFieldModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.italic(.subheadline)()).underline()
                .multilineTextAlignment(.leading)

        }
    }
    private func isFormValid() -> Bool {
        return number.count != 14 || name.isEmpty || dateOfBirth.count != 10 || placeOfBirth.isEmpty || selectedGender == .none
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
                            TextField("XXXX XXXX XXXX", text: $number)
                                .onChange(of: number, { oldValue, newValue in
                                    number = formatNumber(newValue)
                                })
                                .modifier(CardTextFieldModifier())
                                .keyboardType(.numberPad)
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
                            TextField("ABCD ABCD ABCD", text: $name)
                                .onChange(of: name, { oldValue, newValue in
                                    name = oldValue.uppercased()
                                })
                                .modifier(CardTextFieldModifier())
                        }
                        /// Дата рождения
                        HStack {
                            Text("Дата рождения")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.top, 10)
                        HStack {
                            TextField("XX.XX.XXXX", text: $dateOfBirth)
                                .onChange(of: dateOfBirth, { oldValue, newValue in
                                    dateOfBirth = newValue.dateFormateString(newValue)
                                })
                                .modifier(CardTextFieldModifier())
                                .keyboardType(.numberPad)
                            Spacer()
                        }
                        /// Пол
                        HStack {
                            Text("Пол")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("Место рождения")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }.padding(.top, 10)
                        HStack {
                            Menu {
                                ForEach(genders, id: \.self) { gender in
                                    Button(action: { selectedGender = gender
                                    }) {
                                        Text(gender.rawValue).tag(gender)
                                    }
                                }
                            } label: {
                                Text(selectedGender.rawValue)
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                                    .underline()
                            }
                            Spacer()
                            TextField("New York City", text: $placeOfBirth)
                                .onChange(of: placeOfBirth, { oldValue, newValue in
                                    placeOfBirth = oldValue.uppercased()
                                })
                                .multilineTextAlignment(.trailing)
                                .modifier(CardTextFieldModifier())

                        }
                    }.padding(20)
                    Image(.herbInn)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .tint(.innFontInside)
                }
                .padding(.top, 10)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.innInside)
                }
            }
        }
        .environment(\.colorScheme, .light)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.innTop)
        }
    }
    private func formatNumber(_ value: String) -> String {
        let cleanValue = value.replacingOccurrences(of: " ", with: "")
        let formattedValue = cleanValue.chunkFormatted(withChunkSize: 4, withSeparator: " ")
        return String(formattedValue.prefix(14))
    }

    private func saveData() {
        let inn = INNModel(number: number, name: name, gender: selectedGender, dateOfBirth: dateOfBirth, placeOfBirth: placeOfBirth)
        modelContext.insert(inn)
        do {
            try modelContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    AddInnView()
}
