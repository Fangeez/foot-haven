//  Created by Harris Dawurang on 4/5/22.

import SwiftUI

struct LeagueSearchResultScreen: View {
    @Binding var showLeagueResultScreen: Bool
    var leagueName: String
    var leagueLogo: UIImage?
    var leagueStandings: [String]
    var leagueStandingPoints: [Int]
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            TeamInfoCell(teamName: leagueName, teamLogo: leagueLogo)
            StatisticsCell(statNames: leagueStandings, statNumbers: leagueStandingPoints)
        }
    }
}

struct LeagueSearchResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        LeagueSearchResultScreen(showLeagueResultScreen: .constant(true),
                                 leagueName: MockPreviews.leagueName,
                                 leagueLogo: UIImage(systemName: MockPreviews.leagueLogo),
                                 leagueStandings: MockPreviews.leagueStandings,
                                 leagueStandingPoints: MockPreviews.leaguePoints)
    }
}
