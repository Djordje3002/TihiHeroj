import Swift
import SwiftUI

struct CheckboxListView: View {
    let options: [String]
    @Binding var selectedIndices: [Int]
    
    private func toggleSelection(for index: Int) {
        if let existingIndex = selectedIndices.firstIndex(of: index) {
            selectedIndices.remove(at: existingIndex)
        } else {
            selectedIndices.append(index)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(options.indices, id: \.self) { index in
                HStack(spacing: 10) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(selectedIndices.contains(index) ? Color.lilac600 : Color.thunder200, lineWidth: 2)
                            .background(selectedIndices.contains(index) ? Color.lilac600 : Color.thunder200)
                            .frame(width: 28, height: 28)
                        if selectedIndices.contains(index) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                        }
                    }
                    .onTapGesture {
                        toggleSelection(for: index)
                    }
                    Text(options[index])
                        .foregroundColor(.thunder950)
                        .font(.system(size: 17))
                }
                .padding(.vertical, 2)
            }
        }
    }
}
