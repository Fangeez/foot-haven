//  Created by Harris Dawurang on 4/11/22.

struct TeamListsData: Codable {
    let response: [TeamListData]
}

struct TeamListData: Codable {
    let team: TeamListInfo
}

struct TeamListInfo: Codable {
    var id: Int
    var name: String
}
