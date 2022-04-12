//  Created by Harris Dawurang on 4/11/22.

struct LeagueListsData: Codable {
    let response: [LeagueListData]
}

struct LeagueListData: Codable {
    let league: LeagueListInfo
}

struct LeagueListInfo: Codable {
    let id: Int
    let name: String
}
