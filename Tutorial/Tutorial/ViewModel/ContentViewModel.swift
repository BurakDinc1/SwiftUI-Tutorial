//
//  ContentViewModel.swift
//  Tutorial
//
//  Created by Burak Dinç on 24.05.2022.
//

import Foundation
import Combine
import SwiftUI

class ContentViewModel: ObservableObject {
    
    var cancellable = Set<AnyCancellable>()
    
    @Published var userList: [GetUserResponse] = []
    @Published var isLoad: Bool = false
    
    /// Repository' den donen observe nesnesinin icinden kullanicilari ceker ve set eder.
    func getUsers() {
        self.isLoad = true
        UserRepository
            .shared
            .requestGetUser()
            .sink { [unowned self] (response) in
                if(response.error != nil) {
                    print("Get User Response Error: \(String(describing: response.error))")
                } else {
                    if let userResponseValue = response.value {
                        self.userList = userResponseValue
                    }
                }
                self.isLoad = false
            }.store(in: &self.cancellable)
    }
}
