//  Created by Harris Dawurang on 4/4/22.

import SwiftUI

struct TeamSearchView: View {
    @State private var showsTeamResultScreen = false
    @State var countrySelection: String = ""
    @State var leagueSelection: String = ""
    @State var teamSelection: String = ""
    
    var body: some View {
        // TODO:- Replace all mock data with real data
        
        NavigationView {
            VStack(spacing: 50) {
                DropDownView(selection: $countrySelection, placeholder: "Select Country", dropDownList: SearchOptions.countries)
                DropDownView(selection: $leagueSelection, placeholder: "Select League", dropDownList: ["Premier League", "La Liga", "Bundesliga"])
                DropDownView(selection: $teamSelection, placeholder: "Select Team", dropDownList: ["Manchester United", "Liverpool FC", "FC Barcelona"])
                NavigationLink(destination: TeamSearchResultScreen(activeLink: $showsTeamResultScreen), isActive: $showsTeamResultScreen) {
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
