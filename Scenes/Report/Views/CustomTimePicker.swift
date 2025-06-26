//
//  CustomTimePicker.swift
//  TihiHeroj
//
//  Created by Djordje Mitrovic on 17.3.25..
//

import SwiftUI

// Custom Time Picker
struct CustomTimePicker: View {
    @Binding var selectedTime: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Изабери време")
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .foregroundColor(.thunder950)
                Spacer()
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            DatePicker("",
                       selection: $selectedTime,
                       displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding(.horizontal)
            
            Button(action: {
                isPresented = false
            }) {
                Text("Потврди")
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.lilac500)
                    .cornerRadius(10)
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding()
    }
}


//#Preview {
//    CustomTimePicker()
//}
