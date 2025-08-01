import SwiftUI

struct DescriptionText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 17))
            .lineSpacing(6.8)
            .fontWeight(.regular)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.thunder700)
            .padding(.bottom, 18)
    }
}

#Preview {
    DescriptionText(text: "Путем ове апликације можеш пријавити сваки облик насиља које укључује малолетна лица (било да су жртве или починиоци).")
        .padding()
}
