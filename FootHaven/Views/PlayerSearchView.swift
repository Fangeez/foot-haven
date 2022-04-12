//  Created by Harris Dawurang on 4/4/22.

import SwiftUI

struct PlayerSearchView: View {
    @State var countrySelection: String = ""
    @State var leagueSelection: String = ""
    @State var teamSelection: String = ""
    @State var playerSelection: String = ""
    
    var body: some View {
        // TODO:- Replace all mock data with real data
        VStack(spacing: 50) {
            DropDownView(selection: $countrySelection, placeholder: "Select Country", dropDownList: SearchOptions.countries)
            DropDownView(selection: $leagueSelection, placeholder: "Select League", dropDownList: ["Premier League", "La Liga", "Bundesliga"])
            DropDownView(selection: $teamSelection, placeholder: "Select Team", dropDownList: ["Manchester United", "Liverpool FC", "FC Barcelona"])
            DropDownView(selection: $playerSelection, placeholder: "Select Player", dropDownList: ["Lionel Messi", "Neymar Jr.", "Eden Hazard"])
            // TODO:- Update active
            SearchButtonView(activeLink: .constant(true), title: SearchButtonText.player)
        }
    }
}

struct PlayerSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSearchView()
    }
}
