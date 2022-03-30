//  Created by Harris Dawurang on 3/30/22.

struct LeagueData: Codable {
    let league: LeagueInfoData
    let standings: [LeagueStatsData]
}
