//  Created by Harris Dawurang on 4/5/22.

import SwiftUI

struct StatisticsCell: View {
    var statNames: [String]
    var statNumbers: [String]
    var body: some View {
        List {

            ForEach(Array(zip(statNames, statNumbers)), id: \.0) { pair in
                StatRow(statName: pair.0, statNumber: "\(pair.1)")
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
            }
        }
    }
}

struct StatRow: View {
    var statName: String
    var statNumber: String
    var body: some View {
        HStack {
            Text(statName)
            Spacer()
            Text(statNumber)
        }
        .font(Font.system(size: 18))
    }
}

struct TeamStatsCell_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsCell(statNames: MockPreviews.teamStatNames, statNumbers: MockPreviews.teamStatNumbers)
            .previewLayout(.sizeThatFits)
    }
}
