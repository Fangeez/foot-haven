//  Created by Harris Dawurang on 4/24/22.

import SwiftUI

struct PlayerInfoCell: View {
    var playerImage: UIImage?
    var playerName: String
    var playerDetails: [String]

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .padding()
            HStack {
                VStack(spacing: 30) {
                    Image(uiImage: playerImage ?? UIImage())
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    Text(playerName)
                        .font(Font.system(size: 18))
                }
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(playerDetails, id: \.self) { detail in
                        Text(detail)
                    }
                }
                .multilineTextAlignment(.leading)
            }
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))

        }
    }
}

struct PlayerInfoCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerInfoCell(playerImage: UIImage(systemName: MockPreviews.playerImage), playerName: MockPreviews.playerName, playerDetails: MockPreviews.playerDetails)
    }
}
