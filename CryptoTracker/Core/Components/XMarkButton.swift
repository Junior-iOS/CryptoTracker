//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by NJ Development on 13/06/24.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

#Preview {
    XMarkButton()
}
