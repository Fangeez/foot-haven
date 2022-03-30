//  Created by Harris Dawurang on 3/30/22.

struct TeamData: Codable {
    let team: TeamInfoData
    let form: String
    let fixtures: Fixtures
}


struct Fixtures: Codable {
    let played: Played
    let wins: Wins
    let draws: Draws
    let loses: Loses
}

struct Played: Codable{
    let total: Int
}

struct Wins: Codable {
    let total: Int
}

struct Draws: Codable {
    let total: Int
}

struct Loses: Codable {
    let total: Int
}



