//  Created by Harris Dawurang on 4/4/22.

import SwiftUI

struct LeagueSearchView: View {
    @State var countrySelection: String = ""
    @State var leagueSelection: String = ""
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        VStack(spacing: 50) {
            DropDownView(selection: $countrySelection, placeholder: "Select Country", dropDownList: SearchOptions.countries)
                .onChange(of: countrySelection) { _ in
                    networkManager.fetchLeagueLists(country: countrySelection)
                }
            DropDownView(selection: $leagueSelection, placeholder: "Select League", dropDownList: networkManager.leagueLists)
            SearchButtonView(activeLink: .constant(true), title: SearchButtonText.league)
        }
    }
}

struct LeagueSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueSearchView()
    }
}
