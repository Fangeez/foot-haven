//  Created by Harris Dawurang on 3/30/22.

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import UIKit

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
    @Published var teamLogo: UIImage?
    @Published var teamStatNames: [String] = []
    @Published var teamStatNumbers: [Int] = []
    
    // League stats
    @Published var leagueStandings: [String] = []
    @Published var leagueStandingPoints: [Int] = []
    @Published var leagueName: String = ""
    @Published var country: String = ""
    @Published var leagueLogo: UIImage?
    
    // Lists
    @Published var leagueLists: [String] = []
    @Published var teamLists: [String] = []
    @Published var teamObjectLists: [TeamListInfo] = []
    @Published var playerLists: [String] = []
    
    // Dicts
    @Published var leaguesDict: [String: Int] = [:]
    @Published var teamsDict: [String: Int] = [:]
    @Published var playersDict: [String: Int] = [:]
    
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
    
    func fetchPlayerStats(playerId: Int) {
        let playerUrl = "\(baseUrl)?id=\(playerId)&season=2021"
        self.performStatsRequest(url: playerUrl, urlType: UrlTypes.player)
    }
    
    func fetchTeamStats(teamId: Int, leagueId: Int) {
        let teamUrl = "\(baseUrl)/teams/statistics?team=\(teamId)&league=\(leagueId)&season=2021"
        self.performStatsRequest(url: teamUrl, urlType: UrlTypes.team)
    }
    
    func fetchLeagueStats(leagueId: Int) {
        let leagueUrl = "\(baseUrl)/standings?league=\(leagueId)&season=2021"
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
                    var leaguesDict: [String: Int] = [:]
                    for league in parsedData.response {
                        leaguesDict[league.league.name] = league.league.id
                        leagueList.append(league.league.name)
                    }
                    self.leaguesDict = leaguesDict
                    self.leagueLists = leagueList
                }
            }
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
    func fetchTeamLists(league: Int) {
        let teamsUrl = "\(baseUrl)/teams?league=\(league)&season=2021"
        let semaphore = DispatchSemaphore(value: 0)
        var request = URLRequest(url: URL(string: teamsUrl)!, timeoutInterval: Double.infinity)
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
            
            if let parsedData = parseTeamListJSON(data) {
                DispatchQueue.main.async {
                    var teamList: [String] = []
                    var teamsDict: [String: Int] = [:]
                    for team in parsedData.response {
                        teamList.append(team.team.name)
                        teamsDict[team.team.name] = team.team.id
                    }
                    self.teamLists = teamList
                    self.teamsDict = teamsDict
                }
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
    func fetchPlayerLists(team: Int, league: Int) {
        let playersUrl = "\(baseUrl)/players?league=\(league)&team=\(team)&season=2021"
        let semaphore = DispatchSemaphore(value: 0)
        var request = URLRequest(url: URL(string: playersUrl)!, timeoutInterval: Double.infinity)
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
            
            if let parsedData = parsePlayerListJSON(data) {
                DispatchQueue.main.async {
                    var playerList: [String] = []
                    var playerDict: [String: Int] = [:]
                    for player in parsedData.response {
                        let fullName = "\(player.player.firstname) \(player.player.lastname)"
                        playerList.append(fullName)
                        playerDict[fullName] = player.player.id
                    }
                    self.playerLists = playerList
                    self.playersDict = playerDict
                }
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
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
                        self.height = parsedData.player.height ?? "-"
                        self.weight = parsedData.player.weight ?? "-"
                        self.nationality = parsedData.player.nationality
                        self.age = parsedData.player.age ?? 0
                        if let playerPhoto = parsedData.player.photo {
                            self.photo = playerPhoto
                        }
                        self.goals = parsedData.statistics[0].goals.total ?? 0
                        self.assists = parsedData.statistics[0].goals.assists ?? 0
                        self.gamesPlayed = parsedData.statistics[0].games.appearances ?? 0
                        self.tackles = parsedData.statistics[0].tackles.total ?? 0
                        self.dribbleAttempts = parsedData.statistics[0].dribbles.attempts ?? 0
                        self.successfulDribbles = parsedData.statistics[0].dribbles.success ?? 0
                        self.totalPasses = parsedData.statistics[0].passes.total ?? 0
                        self.keyPasses = parsedData.statistics[0].passes.key ?? 0
                        self.interceptions = parsedData.statistics[0].tackles.interceptions ?? 0
                        if let safeConceded = parsedData.statistics[0].goals.conceded,
                           let safeSaved = parsedData.statistics[0].goals.saved {
                            self.conceded = safeConceded
                            self.saved = safeSaved
                        }
                    }
                }
            } else if urlType == UrlTypes.team {
                if let parsedData = parseTeamJSON(data) {
                    DispatchQueue.main.async {
                        self.teamName = parsedData.response.team.name
                        if let logo = parsedData.response.team.logo {
                            let url = NSURL(string: logo)! as URL
                            if let imageData: NSData = NSData(contentsOf: url) {
                                self.teamLogo = UIImage(data: imageData as Data)
                            }
                        }
                        self.teamStatNames = []
                        self.teamStatNumbers = []
                        let played = parsedData.response.fixtures.played.total
                        self.teamStatNames.append("Matches Played")
                        self.teamStatNumbers.append(played)
                        let wins = parsedData.response.fixtures.wins.total
                        self.teamStatNames.append("Matches Won")
                        self.teamStatNumbers.append(wins)
                        let draws = parsedData.response.fixtures.draws.total
                        self.teamStatNames.append("Matches Drawn")
                        self.teamStatNumbers.append(draws)
                        let losses = parsedData.response.fixtures.loses.total
                        self.teamStatNames.append("Matches Lost")
                        self.teamStatNumbers.append(losses)
                    }
                }
            } else {
                if let parsedData = parseLeagueJSON(data) {
                    DispatchQueue.main.async {
                        let leagueStandings = parsedData.response[0].league.standings[0]
                        self.leagueStandings = []
                        self.leagueStandingPoints = []
                        for team in leagueStandings {
                            let name = team.team.name
                            let points = team.points
                            self.leagueStandings.append(name)
                            self.leagueStandingPoints.append(points)
                        }
                        self.leagueName = parsedData.response[0].league.name
                        self.country = parsedData.response[0].league.country
                        if let parsedLogo = parsedData.response[0].league.logo {
                            let url = NSURL(string: parsedLogo)! as URL
                            if let imageData: NSData = NSData(contentsOf: url) {
                                self.leagueLogo = UIImage(data: imageData as Data)
                            }
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
