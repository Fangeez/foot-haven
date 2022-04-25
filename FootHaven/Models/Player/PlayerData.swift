//  Created by Harris Dawurang on 3/30/22.
struct PlayerData: Codable {
    let response: [PlayerResponseData]
}
struct PlayerResponseData: Codable {
    let player: PlayerInfoData
    let statistics: [PlayerStatsData]
}
