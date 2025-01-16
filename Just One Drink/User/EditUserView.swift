//
//  EditUser.swift
//  Just One Drink
//
//  Created by Luke Mulcahy on 1/15/25.
//

import SwiftData
import SwiftUI

struct EditUserView: View {
    
    @Query private var user: [User]
    
    @State var weight: Int = 130
    @State var sex: User.Sex = .male

    var body: some View {
        VStack {
            Text("Edit User Details").font(.largeTitle)
            
            if let user = user.first {
                Picker("Weight", selection: Binding(
                    get: { user.weight },
                    set: { user.weight = $0 }
                )) {
                    ForEach(70...350, id: \.self) {
                        Text("\($0) lbs")
                    }
                }
                .pickerStyle(.wheel)
                
                Picker("Sex", selection: Binding(
                    get: { user.sex },
                    set: { user.sex = $0 }
                )) {
                    ForEach(User.Sex.allCases, id: \.self) { sex in
                        Text(sex.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
            } else {
                Text("No user found").foregroundColor(.red)
            }
        }
    }
}

#Preview {
    EditUserView().modelContainer(PreviewData.shared)
}
