//
//  AddButtonView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 24.02.2024.
//

import SwiftUI

struct AddButtonView: View {
    var saveAction: () -> Void
    var presentationMode: Binding<PresentationMode>

    var body: some View {
        Button(action: {
            saveAction()
            presentationMode.wrappedValue.dismiss()
        }) {
            Label("Сохранить", systemImage: "")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.linearGradient(colors: [Color.blue, Color.sber], startPoint: .topLeading, endPoint: .bottomTrailing))
                }
        }
    }
}

