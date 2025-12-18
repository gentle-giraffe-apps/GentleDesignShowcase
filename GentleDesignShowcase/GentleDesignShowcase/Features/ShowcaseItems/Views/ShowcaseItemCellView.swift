//  Jonathan Ritchey

import SwiftUI

struct ShowcaseItemCellView: View {
    let viewModel: ShowcaseItemCellViewModel
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("name")
                        .font(.footnote).fontWeight(.bold)
                        .foregroundStyle(.primary)
                    Text("description")
                        .font(.footnote).fontWeight(.regular)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 10)
                
                Spacer()
                
//                if viewModel.isUpcoming == false {
                    Image(
                        systemName: viewModel.isCompleted ?
                        "checkmark.seal.fill" : "checkmark.seal"
                    )
                    .font(Font.system(size: 26))
                    .foregroundColor(viewModel.isCompleted ? Color.blue : .secondary) // Color.accent
//                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color(.separator), lineWidth: 1.0)
        )
    }
}
