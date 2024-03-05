//
//  HeaderHomeView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//
import SwiftUI

struct HeaderHomeView: View {
    @State var showSheet = false
    @State var showAddCardView = false
    @State var showAddPassportView = false
    @State var showAddSnilsView = false
    @State var showAddPassportIntView = false
    @State var showAddInnView = false
    @State var showAddDriveView = false
    
    var body: some View {
            Button(action: {
                self.showSheet = true
            }) {
                Text("+")
                    .bold()
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(.primary)
            }
        .actionSheet(isPresented: $showSheet, content: { sheet })
        .sheet(isPresented: $showAddCardView) { AddCardMainView() }
        .sheet(isPresented: $showAddSnilsView) { AddSnilsMainView() }
        .sheet(isPresented: $showAddPassportView) { AddPassportView() }
        .sheet(isPresented: $showAddPassportIntView) { AddIntPassportView() }
        .sheet(isPresented: $showAddInnView) { AddInnMainView() }
        .sheet(isPresented: $showAddDriveView) { AddDriveMainView() }
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
