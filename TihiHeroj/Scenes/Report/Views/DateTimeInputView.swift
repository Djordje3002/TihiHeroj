//
//  DateTimeInputView.swift
//  TihiHeroj
//
//  Created by Djordje Mitrovic on 20.3.25..
//

import SwiftUI

struct DateTimeInputView: View {
    let label: String
    let iconName: String
    @Binding var selectedValue: Date
    @Binding var showPicker: Bool
    let formatter: DateFormatter
    let pickerHeight: CGFloat
    let isDate: Bool // To distinguish between date and time pickers
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.thunder500)
                .padding(.leading, 14)
            
            HStack(spacing: 10) {
                Image(iconName)
                    .foregroundColor(.thunder500)
                Text(formatter.string(from: selectedValue))
                    .foregroundColor(.thunder950)
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.thunder200, lineWidth: 1)
            )
            .onTapGesture {
                showPicker.toggle()
            }
            
            Text("(Обавезно поље)")
                .font(.system(size: 12))
                .foregroundColor(.thunder500)
                .padding(.leading, 14)
        }
        .padding(.vertical, 8)
        .sheet(isPresented: $showPicker) {
            if isDate {
                CustomDatePicker(selectedDate: $selectedValue, isPresented: $showPicker)
                    .frame(maxWidth: .infinity, maxHeight: pickerHeight)
                    .presentationDetents([.height(pickerHeight)])
            } else {
                CustomTimePicker(selectedTime: $selectedValue, isPresented: $showPicker)
                    .frame(maxWidth: .infinity, maxHeight: pickerHeight)
                    .presentationDetents([.height(pickerHeight)])
            }
        }
    }
}

//
//#Preview {
//    DateTimeInputView()
//}
