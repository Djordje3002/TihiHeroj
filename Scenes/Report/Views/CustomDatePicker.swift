// CustomDatePicker.swift
// TihiHeroj
//
// Created by Djordje Mitrovic on 17.3.25.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Изабери датум")
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .foregroundColor(.thunder950)
                Spacer()
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray.opacity(0.5))
                }
            }
            .padding()
            
            DatePicker("",
                       selection: $selectedDate,
                       displayedComponents: .date)
                .datePickerStyle(.graphical)
                .labelsHidden()
                .padding(.horizontal)
                .accentColor(.lilac600)
            
            Button(action: {
                isPresented = false
            }) {
                Text("Потврди")
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.lilac600)
                    .cornerRadius(10)
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var date = Date()
        @State private var isPresented = true
        
        var body: some View {
            CustomDatePicker(selectedDate: $date, isPresented: $isPresented)
        }
    }
    return PreviewWrapper()
}
