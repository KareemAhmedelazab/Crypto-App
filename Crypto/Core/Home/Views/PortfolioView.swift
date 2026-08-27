//
//  PortfolioView.swift
//  Crypto
//
//  Created by Kareem on 27/08/2026.
//

import SwiftUI

struct PortfolioView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("hi")
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XmarkButton()
                }
            }
        }
    }
}

#Preview {
    PortfolioView()
}
