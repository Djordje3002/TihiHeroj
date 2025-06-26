//
//  SettingsView.swift
//  TihiHeroj
//
//  Created by Djordje Mitrovic on 20.2.25..
//

import SwiftUICore
import SwiftUI

struct SettingsView: View {
    @Binding var path: [AppScreen]
    
    var body: some View {
        VStack {
            nav.background(Color.white)
            Spacer()
            ScrollView {
                VStack {
                    Button(action: {
                        path.append(.language)
                    }, label: { settingRow(text: "Језик") })
                    
                    Button(action: {
                        path.append(.organization)
                    }, label: { settingRow(text: "Организације") })
                    
                    Button(action: {
                        if let url = URL(string: "https://kuda-vr.xyz/tihi-heroj/terms-and-conditions") {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        settingRow(text: "Услови и одредбе")
                    })
                    
                    Button(action: {
                        if let url = URL(string: "https://kuda-vr.xyz/tihi-heroj/privacy-policy") {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        settingRow(text: "Политика приватности")
                    })
                    
                    Button(action: {
                        path.append(.licenses)
                    }, label: { settingRow(text: "Лиценце") })
                }
                .padding()
            }
        }
        .background(Color.thunder100)
    }
    
    private func settingRow(text: String) -> some View {
        HStack {
            Text(text)
                .padding()
                .foregroundColor(.thunder950)
            Spacer()
            Image("arrow-right")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.thunder500)
                .padding()
        }
        .frame(height: 44)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal,6)
    }
    
    private var nav: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Text("Подешавања")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(Color.white)
        }
    }
}

#Preview {
    SettingsView(path: .constant([]))
}
