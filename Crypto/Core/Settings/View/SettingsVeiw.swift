//
//  SettingsVeiw.swift
//  Crypto
//
//  Created by Kareem on 30/08/2026.
//

import SwiftUI

struct SettingsVeiw: View {
    
    let defualtURL = URL(string: "https://www.google.com")!
    let gitHubURL = URL(string: "https://github.com/KareemAhmedelazab")!
    let linkedIn = URL(string: "https://www.linkedin.com/in/kareem-el-azab-b63957190/")!
    let coinGecko = URL(string: "https://www.coingecko.com")!
    
    var body: some View {
        NavigationStack {
            List {
                
                cryptoInfo
                
                CoinGeckoSection
                
            }
            
            .navigationTitle("Settings")
            .listStyle(GroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XmarkButton()
                }
            }
        }
    }
}

#Preview {
        SettingsVeiw()
}

extension SettingsVeiw {
    
    private var cryptoInfo: some View {
        
        Section(content: {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("A real-time cryptocurrency tracking app designed to keep you updated with live prices, 7-day interactive charts, and detailed market statistics powered by CoinGecko.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link(destination: gitHubURL) {
                Text("Visit GitHub Repository ↗")
                    .foregroundStyle(.blue)
            }
            
            Link(destination: linkedIn) {
                Text("Visit LinkedIn Profile ↗")
                    .foregroundStyle(.blue)
            }
        }, header: {
            Text("Crypto App")
        })
    }
    
    private var CoinGeckoSection: some View {
        
        Section(content: {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("All cryptocurrency data, live market prices, and historical charts used in this app are provided by CoinGecko's API.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link(destination: coinGecko) {
                Text("Visit CoinGecko ↗")
                    .foregroundStyle(.blue)
            }
            
        }, header: {
            Text("CoinGecko")
        })
    }
    
}
