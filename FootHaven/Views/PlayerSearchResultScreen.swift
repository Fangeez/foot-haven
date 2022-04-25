//  Created by Harris Dawurang on 4/5/22.

import SwiftUI

struct PlayerSearchResultScreen: View {
    @Binding var activeLink: Bool
    var playerImage: UIImage?
    var playerName: String
    var playerDetails: [String]
    var playerStatNames: [String]
    var playerStatNumbers: [String]
    var body: some View {
        ZStack {
            Color("AppColor").opacity(0.09)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 40) {
                PlayerInfoCell(playerImage: playerImage, playerName: playerName, playerDetails: playerDetails)
                StatisticsCell(statNames: playerStatNames, statNumbers: playerStatNumbers)
            }
        }
        .navigationTitle("Player Stats")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                ToolbarBackButton(activeLink: $activeLink)
            }
        }

    }
}

struct PlayerSearchResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSearchResultScreen(activeLink: .constant(true),
                                 playerImage: UIImage(systemName: MockPreviews.playerImage),
                                 playerName: MockPreviews.playerName,
                                 playerDetails: MockPreviews.playerDetails,
                                 playerStatNames: MockPreviews.playerStatNames,
                                 playerStatNumbers: MockPreviews.playerStatNumbers)
    }
}
