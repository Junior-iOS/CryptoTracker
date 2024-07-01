//
//  DetailView.swift
//  CryptoTracker
//
//  Created by NJ Development on 27/06/24.
//

import SwiftUI

struct DetailView: View {
    @Binding var coin: Coin?
    
    init(coin: Binding<Coin?>) {
        self._coin = coin
    }
    
    var body: some View {
        Text(coin?.name ?? "")
    }
}

#Preview {
    DetailView(coin: .constant(DeveloperPreview.shared.coin))
}
