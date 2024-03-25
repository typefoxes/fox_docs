//
//  HeaderHomeView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//
import SwiftUI

/// Структура настраиваемого представления SwiftUI `View` для отображения кнопки "+" с помощью которой, при нажатии, отображается лист с опциями для добавления различных типов
///  - Parameters:
///   - showSheet: Переменная состояния, которая управляет отображением листа с опциями.
///   - showAddCardView: Переменная состояния, которая управляет отображением  "Добавить карту".
///   - showAddPassportView: Переменная состояния, которая управляет отображением  "Добавить паспорт".
///   - showAddSnilsView: Переменная состояния, которая управляет отображением  "Добавить СНИЛС".
///   - showAddPassportIntView: Переменная состояния, которая управляет отображением  "Добавить внутренний паспорт".
///   - showAddInnView: Переменная состояния, которая управляет отображением листа "Добавить ИНН".
///   - showAddDriveView: Переменная состояния, которая управляет отображением листа "Добавить Права".
struct HeaderHomeView: View {

    // MARK: - Properties

    @State var showSheet = false
    @State var showAddCardView = false
    @State var showAddPassportView = false
    @State var showAddSnilsView = false
    @State var showAddPassportIntView = false
    @State var showAddInnView = false
    @State var showAddDriveView = false

    // MARK: - Constants and private properties

    private enum Constants {
        static let titleMain: String = "Fox Docs"
        static let titleButtonName: String = "plus.circle.fill"
        static let sheetTitle: String = "Что добавить?"
        static let cardSheetTitle: String = "Карта"
        static let passportSheetTitle: String = "Паспорт"
        static let driveSheetTitle: String = "Права"
        static let intPassportSheetTitle: String = "Загранник"
        static let snilsSheetTitle: String = "СНИЛС"
        static let innSheetTitle: String = "ИНН"
    }

    private var sheet: ActionSheet {
        let action = ActionSheet(
            title: Text(Constants.sheetTitle),
            message: nil,
            buttons: [
                .default(Text(Constants.cardSheetTitle), action: {
                    showAddCardView = true
                }),
                .default(Text(Constants.passportSheetTitle), action: {
                    showAddPassportView = true
                }),
                .default(Text(Constants.driveSheetTitle), action: {
                    showAddDriveView = true
                }),
                .default(Text(Constants.intPassportSheetTitle), action: {
                    showAddPassportIntView = true
                }),
                .default(Text(Constants.snilsSheetTitle), action: {
                    showAddSnilsView = true
                }),
                .default(Text(Constants.innSheetTitle), action: {
                    showAddInnView = true
                }),
                .cancel({
                    showSheet = false
                })
            ])
        return action
    }

    // MARK: - Body

    var body: some View {
        HStack {
            Spacer()
            Text(Constants.titleMain)
                .font(.title)
                .foregroundColor(Color.primary)
            Spacer()
            Button(action: {
                self.showSheet = true
            }) {
                Image(systemName: Constants.titleButtonName)
                    .font(.title)
            }
            .actionSheet(isPresented: $showSheet, content: {
                sheet
            })
            .sheet(isPresented: $showAddCardView) {
                AddCardMainView()
            }
            .sheet(isPresented: $showAddSnilsView) {
                AddSnilsMainView()
            }
            .sheet(isPresented: $showAddPassportView) {
                AddPassportView()
            }
            .sheet(isPresented: $showAddPassportIntView) {
                AddIntPassportView()
            }
            .sheet(isPresented: $showAddInnView) {
                AddInnMainView()
            }
            .sheet(isPresented: $showAddDriveView) {
                AddDriveMainView()
            }
            .padding(.trailing, 15)
        }
    }
}
