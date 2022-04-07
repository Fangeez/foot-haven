//  Created by Harris Dawurang on 4/5/22.

import SwiftUI

struct TeamInfoCell: View {
    var teamName: String
    var teamLogo: UIImage?
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .padding()

            VStack(spacing: 30) {
                Image(uiImage: teamLogo ?? UIImage())
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                Text(teamName)
                    .font(Font.system(size: 18))
            }
        }

    }
}

struct TeamInfoCell_Previews: PreviewProvider {
    static var previews: some View {
        TeamInfoCell(teamName: MockPreviews.teamName, teamLogo: UIImage(systemName: MockPreviews.teamLogo))
            .previewLayout(.sizeThatFits)
    }
}
