//  Created by Harris Dawurang on 4/6/22.

import SwiftUI

struct ToolbarBackButton: View {
    @Binding var activeLink: Bool
    var body: some View {
        Button {
            activeLink = false
        } label: {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 20, height: 20, alignment: .leading)
                .foregroundColor(Color("AppColor"))
        }
    }
}

struct ToolbarBackButton_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarBackButton(activeLink: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
