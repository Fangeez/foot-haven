//  Created by Harris Dawurang on 4/5/22.

import SwiftUI

struct LeagueSearchResultScreen: View {
    var standings: [String]
    var points: [Int]
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            TeamInfoCell(teamName: MockPreviews.leagueName, teamLogo: UIImage(systemName: MockPreviews.leagueLogo))
            StatisticsCell(statNames: standings, statNumbers: points)
            }
    }
    }

struct LeagueSearchResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        LeagueSearchResultScreen(standings: MockPreviews.leagueStandings, points: MockPreviews.leaguePoints)
    }
}
