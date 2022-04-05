//  Created by Harris Dawurang on 4/5/22.

import SwiftUI

struct TeamSearchResultScreen: View {
    var body: some View {
        // TODO:- Replace mock data with real data
        ZStack {
            Color("AppColor").opacity(0.09)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 40) {
                TeamInfoCell(teamName: MockPreviews.teamName, teamLogo: UIImage(systemName: MockPreviews.teamLogo))
                StatisticsCell(statNames: MockPreviews.teamStatNames, statNumbers: MockPreviews.teamStatNumbers)
            }
        }
    }
}

struct TeamSearchResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        TeamSearchResultScreen()
    }
}
