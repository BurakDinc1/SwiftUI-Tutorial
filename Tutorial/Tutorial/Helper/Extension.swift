//
//  Extension.swift
//  Tutorial
//
//  Created by Burak Dinç on 26.09.2022.
//

import Foundation
import Alamofire

// MARK: - DataRequest
extension DataRequest {
    func fetchServiceWithErrorHandling<T: Codable>(_ completionHandler: @escaping (_ result: WSResult<T>) -> ()){
        responseDecodable{ (response: DataResponse<T, AFError>) in
            let result = response.result
            switch result {
            case .success(let mResponse):
                completionHandler(WSResult.success(mResponse))
            case .failure(let error):
                completionHandler(WSResult.failure(ErrorResponse(message: error.localizedDescription)))
            }
        }
    }
}
