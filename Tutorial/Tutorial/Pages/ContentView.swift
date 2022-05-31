//
//  ContentView.swift
//  Tutorial
//
//  Created by Burak Dinç on 24.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var contentViewModel = ContentViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                if(self.contentViewModel.isLoad) {
                    // MARK: - Loading View
                    ProgressView("Yükleniyor...")
                } else {
                    VStack(alignment: .center, spacing: 10) {
//                        // MARK: - Title
//                        Text("Kullanıcılar")
//                            .textCase(.uppercase)
//                            .font(Font.system(.largeTitle))
//                            .foregroundColor(Color.black)
//                            .padding()
                        // MARK: - ScrollView
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack(alignment: .center, spacing: 10) {
                                ForEach(self.contentViewModel.userList, id: \.id) { user in
                                    if let userName = user.name,
                                       let userAddress = user.address?.city {
                                        NavigationLink {
                                            // MARK: - Navigate User Detail
                                            UserDetailView(user: user)
                                        } label: {
                                            // MARK: - User List Item
                                            VStack(alignment: .center, spacing: 10) {
                                                HStack(alignment: .center, spacing: 10) {
                                                    Text("İsim:")
                                                        .foregroundColor(Color.blue)
                                                    Text(userName)
                                                        .foregroundColor(Color.black)
                                                    Spacer()
                                                }
                                                HStack(alignment: .center, spacing: 10) {
                                                    Text("Şehir:")
                                                        .foregroundColor(Color.blue)
                                                    Text(userAddress)
                                                        .foregroundColor(Color.black)
                                                    Spacer()
                                                }
                                                Divider()
                                            }
                                            .padding(.horizontal)
                                        }
                                    } else {
                                        // MARK: - User Not Found
                                        Text("Kullanıcı bulunmuyor !")
                                            .foregroundColor(Color.red)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                self.contentViewModel.getUsers()
            }
            .navigationTitle(Text("Kullanıcılar"))
        }
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
