//  Created by Harris Dawurang on 4/4/22.

import SwiftUI

struct LeagueSearchView: View {
    @State private var showLeagueResultScreen = false
    @State var countrySelection: String = ""
    @State var leagueSelection: String = ""

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
                    networkManager.fetchLeagueStats(leagueId: leagueId)
                }
                NavigationLink(destination: LeagueSearchResultScreen(showLeagueResultScreen: $showLeagueResultScreen,
                                                                     leagueName: networkManager.leagueName, leagueLogo: networkManager.leagueLogo,
                                                                     leagueStandings: networkManager.leagueStandings,
                                                                     leagueStandingPoints: networkManager.leagueStandingPoints),
                               isActive: $showLeagueResultScreen) {
                    SearchButtonView(activeLink: $showLeagueResultScreen,
                                     title: SearchButtonText.league)
                }

            }
        }

    }
}

struct LeagueSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueSearchView()
    }
}
