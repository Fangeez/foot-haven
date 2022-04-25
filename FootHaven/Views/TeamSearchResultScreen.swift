//  Created by Harris Dawurang on 4/5/22.

import SwiftUI

struct TeamSearchResultScreen: View {
    @Binding var activeLink: Bool
    var teamLogo: UIImage?
    var teamName: String
    var teamStatNames: [String]
    var teamStatNumbers: [Int]

    var body: some View {
        ZStack {
            Color("AppColor").opacity(0.09)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 40) {
                TeamInfoCell(teamName: teamName, teamLogo: teamLogo)
                StatisticsCell(statNames: teamStatNames, statNumbers: teamStatNumbers)
            }
        }
        .navigationTitle("Team Stats")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                ToolbarBackButton(activeLink: $activeLink)
            }
        }
    }
}

struct TeamSearchResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        TeamSearchResultScreen(activeLink: .constant(true),
                               teamLogo: UIImage(systemName: MockPreviews.teamLogo),
                               teamName: MockPreviews.teamName,
                               teamStatNames: MockPreviews.teamStatNames,
                               teamStatNumbers: MockPreviews.teamStatNumbers)
    }
}
