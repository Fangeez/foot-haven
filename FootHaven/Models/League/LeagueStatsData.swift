//  Created by Harris Dawurang on 3/30/22.

struct LeagueStatsData {
    let teamStandings: [TeamStanding]
}

struct TeamStanding: Codable {
    let rank: Int
    let team: TeamInfoData
    let points: Int
    let goalsDiff: Int
}
