//
//  CurrencyPickerView.swift
//  CryptoTracker
//
//  Created by NJ Development on 01/06/24.
//

import SwiftUI

public enum CurrencyPicker: String, CaseIterable {
    case BRL, USD
}

struct CurrencyPickerView: View {
    @State var currency: CurrencyPicker = .BRL
    var action: (CurrencyPicker) -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("Currency")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            
            Picker("CurrencyPickerView", selection: $currency) {
                ForEach(CurrencyPicker.allCases, id: \.self) { currency in
                    Text(currency.rawValue)
                        .font(.headline)
                }
            }
            .onChange(of: currency, { _, newValue in
                action(newValue)
            })
            .accentColor(Color.theme.green)
        }
    }
}

#Preview {
    CurrencyPickerView(action: { currency in })
        .padding(/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/)
}
