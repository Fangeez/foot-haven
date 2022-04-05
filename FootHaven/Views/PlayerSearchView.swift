//  Created by Harris Dawurang on 4/4/22.

import SwiftUI

struct PlayerSearchView: View {
    var body: some View {
        // TODO:- Replace all mock data with real data
        VStack(spacing: 50) {
            DropDownView(placeholder: "Select Country", dropDownList: ["England", "Spain", "Germany"])
            DropDownView(placeholder: "Select League", dropDownList: ["Premier League", "La Liga", "Bundesliga"])
            DropDownView(placeholder: "Select Team", dropDownList: ["Manchester United", "Liverpool FC", "FC Barcelona"])
            DropDownView(placeholder: "Select Player", dropDownList: ["Lionel Messi", "Neymar Jr.", "Eden Hazard"])
            SearchButtonView(title: SearchButtonText.player)

        }
    }
}

struct PlayerSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSearchView()
    }
}
