//  Created by Harris Dawurang on 3/30/22.

struct LeagueData: Codable {
    let response: [LeagueResponseData]
}

struct LeagueResponseData: Codable {
    let league: LeagueInfoData
}
