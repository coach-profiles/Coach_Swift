//
//  ProfileEditView.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/21/22.
//

import SwiftUI

struct ProfileEditView: View {
    @Binding var data: Profile.Data
    @State private var newProfileName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Profile Info")) {
                TextField("Name", text: $data.name)
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(data: .constant(Profile.sampleData[0].data))
    }
}
