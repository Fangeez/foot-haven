//  Created by Harris Dawurang on 4/4/22.

import SwiftUI

struct PlayerSearchView: View {
    @State var showPlayerResultScreen: Bool = false
    @State var countrySelection: String = ""
    @State var leagueSelection: String = ""
    @State var teamSelection: String = ""
    @State var playerSelection: String = ""

    @ObservedObject var networkManager = NetworkManager()

    var body: some View {
        VStack(spacing: 50) {
            DropDownView(selection: $countrySelection,
                         placeholder: "Select Country",
                         dropDownList: SearchOptions.countries)
            .onChange(of: countrySelection) { _ in
                networkManager.fetchLeagueLists(country: countrySelection)
            }
            DropDownView(selection: $leagueSelection,
                         placeholder: "Select League",
                         dropDownList: networkManager.leagueLists)
            .onChange(of: leagueSelection) { _ in
                guard let leagueId = networkManager.leaguesDict[leagueSelection] else { return }
                networkManager.fetchTeamLists(league: leagueId)
            }
            DropDownView(selection: $teamSelection,
                         placeholder: "Select Team",
                         dropDownList: networkManager.teamLists)
            .onChange(of: teamSelection) { _ in
                guard let teamId = networkManager.teamsDict[teamSelection] else { return }
                guard let leagueId = networkManager.leaguesDict[leagueSelection] else { return }
                networkManager.fetchPlayerLists(team: teamId,
                                                league: leagueId )
            }
            DropDownView(selection: $playerSelection,
                         placeholder: "Select Player",
                         dropDownList: networkManager.playerLists)
            SearchButtonView(activeLink: $showPlayerResultScreen,
                             title: SearchButtonText.player)
        }
    }
}

struct PlayerSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSearchView()
    }
}
