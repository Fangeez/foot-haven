//  Created by Harris Dawurang on 4/4/22.

import SwiftUI

struct DropDownView: View {
    @State var value = ""
    var placeholder: String
    var dropDownList: [String]
    var body: some View {
        Menu {
            ForEach(dropDownList, id: \.self) { client in
                Button(client) {
                    self.value = client
                }
            }
        } label: {
            VStack(spacing: 5) {
                HStack {
                    Text(value.isEmpty ? placeholder : value)
                        .foregroundColor(value.isEmpty ? .gray : .black)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color("AppColor"))
                        .font(Font.system(size: 20, weight: .bold))
                }
                .padding(.horizontal)
                Rectangle()
                    .fill(Color("AppColor"))
                    .frame(height: 2)
                    .padding(.horizontal)
            }
        }
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView(placeholder: "Select Item", dropDownList: ["PSO", "PFA", "AIR", "HOT"])
    }
}
