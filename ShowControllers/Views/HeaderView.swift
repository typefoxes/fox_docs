//
//  HeaderView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 20.02.2024.
//

import SwiftUI

struct HeaderView: View {
    @Binding var showAlert: Bool
    var title: String
    var deleteAction: () -> Void
    var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack {
            Text(title)
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
                    deleteAction()
                    presentationMode.wrappedValue.dismiss()
                }
                )
            }
        }
        .padding(.vertical, 20)
    }
}
