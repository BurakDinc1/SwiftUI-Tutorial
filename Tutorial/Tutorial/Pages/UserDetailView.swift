//
//  UserDetailView.swift
//  Tutorial
//
//  Created by Burak Dinç on 24.05.2022.
//

import SwiftUI

struct UserDetailView: View {
    
    @State var user: GetUserResponse
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            if let userID = self.user.userID,
               let userName = self.user.name,
               let userEmail = self.user.email,
               let userCity = self.user.address?.city,
               let userStreet = self.user.address?.city,
               let userZipCode = self.user.address?.zipcode {
                HStack(alignment: .center, spacing: 10) {
                    Text("ID:")
                        .foregroundColor(Color.blue)
                    Text("\(userID)")
                        .foregroundColor(Color.black)
                    Spacer()
                }
                HStack(alignment: .center, spacing: 10) {
                    Text("İsim:")
                        .foregroundColor(Color.blue)
                    Text(userName)
                        .foregroundColor(Color.black)
                    Spacer()
                }
                HStack(alignment: .center, spacing: 10) {
                    Text("Email:")
                        .foregroundColor(Color.blue)
                    Text(userEmail)
                        .foregroundColor(Color.black)
                    Spacer()
                }
                HStack(alignment: .center, spacing: 10) {
                    Text("Address:")
                        .foregroundColor(Color.blue)
                    Text("\(userCity), \(userStreet), \(userZipCode)")
                        .foregroundColor(Color.black)
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: GetUserResponse())
    }
}
