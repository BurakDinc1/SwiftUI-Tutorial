//
//  UserRepository.swift
//  Tutorial
//
//  Created by Burak Dinç on 24.05.2022.
//

import Foundation
import Combine
import Alamofire

class UserRepository {
    
    static let shared = UserRepository()
    
    /// Get User Request'i ni dinleyebilmek icin bir observe nesnesi doner.
    /// Eski kullanimi
    public func requestGetUser() -> AnyPublisher<DataResponse<[GetUserResponse], NetworkError>, Never> {
        return AlamofireService.shared.requestGetUsers()
            .validate()
            .publishDecodable(type: [GetUserResponse].self)
            .map { response in
                response.mapError { (error) in
                    return NetworkError(initialError: error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// Get User Request'i ni dinleyebilmek icin bir observe nesnesi doner.
    /// Yeni kullanimi
    public func requestGetUserAlternative() -> AnyPublisher<WSResult<[GetUserResponse]>, Never> {
        Deferred {
            Future { promise in
                AlamofireService
                    .shared
                    .requestGetUsersAlternative { result in
                        promise(.success(result))
                    }
            }
        }.eraseToAnyPublisher()
    }
    
}
