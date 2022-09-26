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
    
    private var cancellable = Set<AnyCancellable>()
    
    @Published var userList: [GetUserResponse] = []
    @Published var isLoad: Bool = false
    
    /// Repository' den donen observe nesnesinin icinden kullanicilari ceker ve set eder.
    /// Eski hali
    public func getUsers() {
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
    
    /// Repository' den donen observe nesnesinin icinden kullanicilari ceker ve set eder.
    /// Yeni kullanimi.
    public func getUsersAlternative() {
        self.isLoad = true
        UserRepository
            .shared
            .requestGetUserAlternative()
            .sink { [unowned self] (result) in
                switch result {
                case .success(let response):
                    self.userList = response
                    self.isLoad = false
                    break
                case .failure(let errorResponse):
                    print("Get User Response Error: \(String(describing: errorResponse.message))")
                    self.isLoad = false
                    break
                }
            }.store(in: &self.cancellable)
    }
    
    // View Modelimiz deinit oldugunda dinleyicilerimizi durduracak.
    deinit {
        self.cancellable.removeAll()
    }
}
