//  Created by Harris Dawurang on 3/30/22.

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class NetworkManager: ObservableObject {
    // Player stats
    @Published var goals: Int = 0
    @Published var assists: Int = 0
    @Published var gamesPlayed: Int = 0
    @Published var tackles: Int = 0
    @Published var interceptions: Int = 0
    @Published var conceded: Int = 0
    @Published var saved: Int = 0
    @Published var dribbleAttempts: Int = 0
    @Published var totalPasses: Int = 0
    @Published var keyPasses: Int = 0
    @Published var successfulDribbles: Int = 0
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var nationality: String = ""
    @Published var age: Int = 0
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var photo: String? = ""
    
    // Team stats
    @Published var teamName: String = ""
    @Published var teamLogo: String = ""
    @Published var played: Int = 0
    @Published var wins: Int = 0
    @Published var draws: Int = 0
    @Published var loses: Int = 0
    
    // League stats
    @Published var leagueStandings: [TeamStandingData] = []
    @Published var leagueName: String = ""
    @Published var country: String = ""
    @Published var leagueLogo: String = ""
    
    // Lists
    @Published var leagueLists: [String] = []
    
    private let baseUrl: String = "https://v3.football.api-sports.io"
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "APIFootball-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'APIFFootball-Info.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'APIFootball-Info.plist'.")
            }
            return value
        }
    }
    
    func fetchPlayerStats(playerId: Int, season: Int) {
        let playerUrl = "\(baseUrl)?id=\(playerId)&season=\(season)"
        self.performStatsRequest(url: playerUrl, urlType: UrlTypes.player)
    }
    
    func fetchTeamStats(teamId: Int, leagueId: Int, season: Int) {
        let teamUrl = "\(baseUrl)?team=\(teamId)&league=\(leagueId)&season=\(season)"
        self.performStatsRequest(url: teamUrl, urlType: UrlTypes.team)
    }
    
    func fetchLeagueStats(leagueId: Int, season: Int) {
        let leagueUrl = "\(baseUrl)?league=\(leagueId)&season=\(season)"
        self.performStatsRequest(url: leagueUrl, urlType: UrlTypes.league)
    }
    
    func fetchLeagueLists(country: String) {
        let leaguesUrl = "\(baseUrl)/leagues?country=\(country)&season=2021"
        let semaphore = DispatchSemaphore(value: 0)
        
        var request = URLRequest(url: URL(string: leaguesUrl)!, timeoutInterval: Double.infinity)
        request.addValue(self.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.addValue(self.baseUrl, forHTTPHeaderField: "x-rapidapi-host")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
            if let parsedData = parseLeagueListJSON(data) {
                DispatchQueue.main.async {
                    var leagueList: [String] = []
                    for league in parsedData.response {
                        leagueList.append(league.league.name)
                    }
                    self.leagueLists = leagueList
                }
            }
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
    func fetchTeamLists(league: String) {
        
    }
    
    func fetchPlayerLists(team: String) {
        
    }
    
    private func performStatsRequest(url: String, urlType: UrlTypes) {
        let semaphore = DispatchSemaphore(value: 0)
        
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: Double.infinity)
        request.addValue(self.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.addValue(self.baseUrl, forHTTPHeaderField: "x-rapidapi-host")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            print(String(data: data, encoding: .utf8)!)
            if urlType == UrlTypes.player {
                if let parsedData = parsePlayerJSON(data) {
                    DispatchQueue.main.async {
                        self.firstname = parsedData.player.firstname
                        self.lastname = parsedData.player.lastname
                        self.height = parsedData.player.height
                        self.weight = parsedData.player.weight
                        self.nationality = parsedData.player.nationality
                        self.age = parsedData.player.age
                        if let playerPhoto = parsedData.player.photo {
                            self.photo = playerPhoto
                        }
                        self.goals = parsedData.statistics[0].goals.total
                        self.assists = parsedData.statistics[0].goals.assists
                        self.gamesPlayed = parsedData.statistics[0].games.appearances
                        self.tackles = parsedData.statistics[0].tackles.total
                        self.dribbleAttempts = parsedData.statistics[0].dribbles.attempts
                        self.successfulDribbles = parsedData.statistics[0].dribbles.success
                        self.totalPasses = parsedData.statistics[0].passes.total
                        self.keyPasses = parsedData.statistics[0].passes.key
                        self.interceptions = parsedData.statistics[0].tackles.interceptions
                        if let safeConceded = parsedData.statistics[0].goals.conceded, let safeSaved = parsedData.statistics[0].goals.saved {
                            self.conceded = safeConceded
                            self.saved = safeSaved
                        }
                    }
                }
            } else if urlType == UrlTypes.team {
                if let parsedData = parseTeamJSON(data) {
                    DispatchQueue.main.async {
                        self.teamName = parsedData.team.name
                        if let logo = parsedData.team.logo {
                            self.teamLogo = logo
                        }
                        self.played = parsedData.fixtures.played.total
                        self.wins = parsedData.fixtures.wins.total
                        self.draws = parsedData.fixtures.draws.total
                        self.loses = parsedData.fixtures.loses.total
                    }
                }
            } else {
                if let parsedData = parseLeagueJSON(data) {
                    DispatchQueue.main.async {
                        self.leagueStandings = parsedData.standings[0]
                        self.leagueName = parsedData.league.name
                        self.country = parsedData.league.country
                        if let parsedLogo = parsedData.league.logo {
                            self.leagueLogo = parsedLogo
                        }
                    }
                }
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
}
