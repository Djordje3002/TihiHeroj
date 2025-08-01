//
//  LunchAnimationView.swift
//  TihiHeroj
//
//  Created by Djordje Mitrovic on 8.10.24..
//

import SwiftUI

struct LunchAnimationView: View {
    
    @State private var isActive = false
    @State private var imageOffset: CGSize = .zero
    @State private var imageScale: CGFloat = 1.0
    
    var body: some View {
        
        if isActive{
            HomeScreenView()
        }else{
            VStack{
                Spacer()
                Image("LogoStart")
                    .resizable()
                    .scaledToFit()
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                    .onAppear {
                        // Odloži pomeranje slike
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2   ) {
                            withAnimation(.easeInOut) {
                                imageOffset = CGSize(width: -UIScreen.main.bounds.width / 2 + 70,
                                                     height: -UIScreen.main.bounds.height / 2 + 70)
                                imageScale = 0.8
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6
                        ) {
                        self.isActive = true
                        }
                    }
                Spacer()
                Image("Logos")
                Text("splash_info")
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                    .lineSpacing(19.2 - 12)
                    .kerning(0.4)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.thunder700))
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        
           
        }
        
        }
        
        

#Preview {
    LunchAnimationView()
}
