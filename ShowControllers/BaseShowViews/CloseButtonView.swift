//
//  CloseButtonView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 20.02.2024.
//

import SwiftUI

struct CloseButtonView: View {
    var presentationMode: Binding<PresentationMode>
    
    var body: some View {
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
}
