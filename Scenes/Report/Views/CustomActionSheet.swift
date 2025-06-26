//
//  CustomActionSheet.swift
//  TihiHeroj
//
//  Created by Djordje Mitrovic on 20.3.25..
//

import SwiftUI


struct CustomActionSheet: View {
    @Binding var isPresented: Bool
    let onCamera: () -> Void
    let onGallery: () -> Void
    let onDocuments: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {

            HStack {
                Spacer()
                Text("Додај прилог")
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    
                Spacer()
                Button(action: {
                    isPresented = false
                }) {
                    Image("cancelcircle2")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
            }
            .padding()
            .background(Color.white)
            .padding(.bottom, 40)
            .padding(.top)
            
            
            // Options
            VStack(spacing: 0) {
                Button(action: {
                    onCamera()
                    isPresented = false
                }) {
                    HStack {
                        Text("Камера")
                            .foregroundColor(.black)
                            .font(.system(size: 17))
                        Spacer()
                        Image("camera")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white)
                }
                
                Divider()
                
                Button(action: {
                    onGallery()
                    isPresented = false
                }) {
                    HStack {
                        Text("Галерија")
                            .foregroundColor(.black)
                            .font(.system(size: 17))
                        Spacer()
                        Image("galery")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white)
                }
                
                Divider()
                
                Button(action: {
                    onDocuments()
                    isPresented = false
                }) {
                    HStack {
                        Text("Документи")
                            .foregroundColor(.black)
                            .font(.system(size: 17))
                        Spacer()
                        Image("document")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white)
                }
            }
            
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}

//#Preview {
//    CustomActionSheet()
//}
