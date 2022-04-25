//  Created by Harris Dawurang on 3/30/22.

struct PlayerStatsData: Codable {
    let team: Team
    let goals: Goals
    let games: Games
    let tackles: Tackles
    let dribbles: Dribbles
    let passes: Passes
}

struct Team: Codable {
    let id: Int
    let name: String
    let logo: String?
}

struct Goals: Codable {
    let total: Int?
    let assists: Int?
    let conceded: Int?
    let saved: Int?
}

struct Games: Codable {
    let appearences: Int?
    let minutes: Int?
}

struct Tackles: Codable {
    let total: Int?
    let interceptions: Int?
}

struct Dribbles: Codable {
    let attempts: Int?
    let success: Int?
}

struct Passes: Codable {
    let total: Int?
    let key: Int?
}
