//
//  LeagueSearchView.swift
//  FootHaven
//
//  Created by Harris Dawurang on 4/4/22.
//

import SwiftUI

struct LeagueSearchView: View {
    var body: some View {
        
        VStack(spacing: 50) {
            DropDownView(placeholder: "Select Country", dropDownList: ["England", "Spain", "Germany"])
            DropDownView(placeholder: "Select League", dropDownList: ["Premier League", "La Liga", "Bundesliga"])
            SearchButtonView(title: SearchButtonText.league)
        }
    }
}

struct LeagueSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueSearchView()
    }
}
