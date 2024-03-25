//
//  HeaderView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 20.02.2024.
//

import SwiftUI

struct HeaderShowView: View {

    // MARK: - Constants

    private enum Constants {
        static let imageName: String = "trash.circle.fill"
        static let alertTitle: String = "Вы хотите удалить этот документ?"
        static let primaryButtonTitle: String = "Отменить"
        static let secondaryButtonTitle: String = "Удалить"
        static let leadingPadding: CGFloat = 10
        static let verticalPadding: CGFloat = 20
    }

    // MARK: - Properties

    @Binding var showAlert: Bool
    var title: String
    var deleteAction: () -> Void
    var presentationMode: Binding<PresentationMode>
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(title)
                .font(.title3)
                .padding(.leading, Constants.leadingPadding)
            Spacer()
            Button {
                showAlert = true
            } label: {
                Image(systemName: Constants.imageName)
                    .font(.title2)
                    .foregroundColor(.red)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(Constants.alertTitle),
                      primaryButton: .cancel(
                        Text(
                            Constants.primaryButtonTitle
                        )
                      ),
                      secondaryButton: .destructive(
                        Text(
                            Constants.secondaryButtonTitle
                        )
                      ){
                    deleteAction()
                    presentationMode.wrappedValue.dismiss()
                }
                )
            }
        }
        .padding(.vertical, Constants.verticalPadding)
    }
}
