//  Created by Harris Dawurang on 4/5/22.

import UIKit

struct SearchButtonText {
    static let player: String = "Search Player Stats"
    static let team: String = "Search Team Stats"
    static let league: String = "Search League Stats"
}

struct MockPreviews {
    static let playerName: String = "Crispy Bacon"
    static let playerImage: String = "person.circle.fill"
    static let playerDetails: [String] = ["Nigeria", "25", "5'9", "180 lbs"]
    static let playerStatNames: [String] = [
        "Games Played", "Goals", "Assists", "Total Passes", "Key Passes", "Tackles",
        "Interceptions", "Conceded", "Saved", "Dribble Attempts", "Successful Dribbles"
    ]
    static let playerStatNumbers: [String] = ["19", "14", "5", "140", "18", "6", "2", "0", "0", "29", "20"]
    static let teamName: String = "Tokyo Revengers"
    static let teamLogo: String = "dongsign.circle.fill"
    static let teamStatNames: [String] = ["Games Played", "Wins", "Draws", "Losses"]
    static let teamStatNumbers: [String] = ["19", "9", "5", "5"]
    static let leagueStandings: [String] =
    ["Manchester City", "Liverpool", "Chelsea", "Arsenal", "Manchester United", "Tottenham Hotspur"]
    static let leaguePoints: [String] = ["87", "85", "72", "67", "60", "59"]
    static let leagueName: String = "Premier League"
    static let leagueLogo: String = "ant.fill"
}

struct SearchOptions {
    static let countries: [String] = ["England", "Spain", "Germany", "France", "Portugal"]
}
