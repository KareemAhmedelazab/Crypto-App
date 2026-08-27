//
//  SearchBarView.swift
//  Crypto
//
//  Created by Kareem on 24/08/2026.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? 
                                 Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .submitLabel(.search)
                .autocorrectionDisabled()
                .textContentType(.oneTimeCode)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                }
            
        }
        .font(.headline)
        .padding()
        .background(Color.theme.background)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(color: Color.theme.accent.opacity(0.15), radius: 10)
        .padding()

        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
}
