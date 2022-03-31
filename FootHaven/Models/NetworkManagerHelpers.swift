//  Created by Harris Dawurang on 3/30/22.

import Foundation

func parsePlayerJSON(_ playerData: Data) -> PlayerData?{
    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode(PlayerData.self, from: playerData)
        return decodedData
    } catch{
        print(error)
        return nil
    }
}
func parseTeamJSON(_ teamData: Data) -> TeamData?{
    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode(TeamData.self, from: teamData)
        return decodedData
    } catch{
        print(error)
        return nil
    }
}
func parseLeagueJSON(_ leagueData: Data) -> LeagueData?{
    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode(LeagueData.self, from: leagueData)
        return decodedData
    } catch{
        print(error)
        return nil
    }
}

