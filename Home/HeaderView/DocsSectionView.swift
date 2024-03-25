//
//  DocsSectionView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI
import SwiftData

// MARK: - DocumentTypeView

struct DocumentTypeView: View {

    // MARK: - Properties

    let documentType: DocumentType
    let onTapAction: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            Text(documentType.getType())
                .foregroundColor(.white)
                .font(.title2)
            Text(documentType.getNumber())
                .foregroundColor(.white)
                .font(.title2)
                .padding(.top, 20)
        }
        .onTapGesture {
            onTapAction()
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(documentType.getGradient())
        )
    }
}

// MARK: - DocsSectionView

struct DocsSectionView: View {

    // MARK: - Private properties

    @Query private var passports: [PassportModel]
    @Query private var snils: [SnilsModel]
    @Query private var passportInt: [PassportIntModel]
    @Query private var inn: [INNModel]
    @Query private var drive: [DriveModel]
    @State private var selectedDocument: DocumentWrapper?

    private enum Constants {
        static let headerTitle: String = "Документы"
        static let sectionFrameHeight: CGFloat = 200
    }
    // MARK: - Body

    var body: some View {
        let allDocuments = setAllDocument()
        Section(header: Text(Constants.headerTitle)) {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(allDocuments) { document in
                        DocumentTypeView(documentType: getDocumentType(document.document)) {
                            selectedDocument = document
                        }
                    }
                }
            }
            .frame(height: Constants.sectionFrameHeight)
        }
        .sheet(item: $selectedDocument) { documentWrapper in
            switch getDocumentType(documentWrapper.document) {
            case .passport(let passport):
                ShowPassportView(passport: passport)
            case .snils(let snils):
                ShowSnilsView(snils: snils)
            case .passportInt(let passportInt):
                ShowPassportIntView(passport: passportInt)
            case .inn(let inn):
                ShowInnView(inn: inn)
            case .drive(let drive):
                ShowDriveLicensView(drive: drive)
            }
        }
    }

    // MARK: - Private functions

    private func getDocumentType(_ document: Any) -> DocumentType {
        if let passport = document as? PassportModel {
            return .passport(passport)
        } else if let snils = document as? SnilsModel {
            return .snils(snils)
        } else if let passportInt = document as? PassportIntModel {
            return .passportInt(passportInt)
        } else if let inn = document as? INNModel {
            return .inn(inn)
        } else if let drive = document as? DriveModel {
            return .drive(drive)
        } else {
            fatalError("Unknown document type")
        }
    }

    private func setAllDocument() -> [DocumentWrapper] {
        var allDocs: [DocumentWrapper] = []

        allDocs.append(contentsOf: passports.map {
            DocumentWrapper(document: $0)
        })
        allDocs.append(contentsOf: snils.map {
            DocumentWrapper(document: $0)
        })
        allDocs.append(contentsOf: passportInt.map {
            DocumentWrapper(document: $0)
        })
        allDocs.append(contentsOf: inn.map {
            DocumentWrapper(document: $0)
        })
        allDocs.append(contentsOf: drive.map {
            DocumentWrapper(document: $0)
        })
        return allDocs
    }
}
