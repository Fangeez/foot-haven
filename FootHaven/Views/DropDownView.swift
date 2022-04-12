//  Created by Harris Dawurang on 4/4/22.

import SwiftUI

struct DropDownView: View {
    @State var value = ""
    @Binding var selection: String
    
    var placeholder: String
    var dropDownList: [String]
    var body: some View {
        Menu {
            ForEach(dropDownList, id: \.self) { client in
                Button(client) {
                    self.value = client
                    self.selection = value
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
        DropDownView(selection: .constant(""), placeholder: "Select Item", dropDownList: ["PSO", "PFA", "AIR", "HOT"])
    }
}
