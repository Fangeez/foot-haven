//  Created by Harris Dawurang on 4/4/22.

import SwiftUI

struct TeamSearchView: View {
    @State private var showsTeamResultScreen = false
    @State var countrySelection: String = ""
    @State var leagueSelection: String = ""
    @State var teamSelection: String = ""
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        NavigationView {
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
                onChange(of: teamSelection) { _ in
                    guard let teamId = networkManager.teamsDict[teamSelection] else { return }
                    guard let leagueId = networkManager.leaguesDict[leagueSelection] else { return }
                    networkManager.fetchTeamStats(teamId: teamId, leagueId: leagueId)
                }
                NavigationLink(destination: TeamSearchResultScreen(
                    activeLink: $showsTeamResultScreen,
                    teamLogo: networkManager.teamLogo,
                    teamName: networkManager.teamName,
                    teamStatNames: networkManager.teamStatNames,
                    teamStatNumbers: networkManager.teamStatNumbers),
                               isActive: $showsTeamResultScreen) {
                    SearchButtonView(activeLink: $showsTeamResultScreen, title: SearchButtonText.team)
                }
            }
        }
    }
}

struct TeamSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TeamSearchView()
    }
}
