//  Created by Harris Dawurang on 3/31/22.

import SwiftUI

struct WelcomeOptionCellView: View {
    let title: String
    let image: String
    var body: some View {
        Button {
            print("yes")
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .shadow(radius: 1)
                .overlay {
                    HStack(spacing: 10) {
                        Image(systemName: image)
                            .foregroundColor(.black)
                        Text(title)
                            .foregroundColor(.black)
                            .font(Font.system(.title3))
                            .background(Color.white)
                    }
                }
        }
    }
}

struct WelcomeOptionCellView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeOptionCellView(title: "Test", image: "eye")
            .previewLayout(.sizeThatFits)
    }
}
