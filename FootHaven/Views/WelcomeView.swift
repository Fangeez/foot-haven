//
//  WelcomeView.swift
//  FootHaven
//
//  Created by Harris Dawurang on 3/31/22.
//

import SwiftUI

struct WelcomeView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            PlayerSearchView()
                .tabItem {
                    Image(selection == 0 ? "player-fill" : "player")
                }
                .tag(0)
            TeamSearchView()
                .tabItem {
                    Image(selection == 1 ? "team-fill" : "team")
                }
                .tag(1)
            LeagueSearchView()
                .tabItem {
                    Image(selection == 2 ? "league-fill" : "league")
                }
                .tag(2)
        }
        .ignoresSafeArea()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
