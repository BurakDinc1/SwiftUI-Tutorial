//
//  GetUserResponse.swift
//  Tutorial
//
//  Created by Burak Dinç on 24.05.2022.
//

import Foundation
import Alamofire

// MARK: - Network Error
struct NetworkError: Error {
  let initialError: AFError
}

// MARK: - GetUserResponse
struct GetUserResponse: Codable, Identifiable {
    // -> Listelemek için Identifiable' den kalıtım altık
    var id: UUID = UUID() // --> Model ilk oluştuğunda artık bir unique ID ile oluşturulacak.
    var userID: Int? // -> Response' dan donen ID
    var name: String?
    var username: String?
    var email: String?
    var address: Address?
    var phone: String?
    var website: String?
    var company: Company?

    enum CodingKeys: String, CodingKey {
        case userID = "id" // -> Response' dan dönen ID' yi Kfarklı isimlendirdik.
        case name = "name"
        case username = "username"
        case email = "email"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
    }
}

// MARK: - Address
struct Address: Codable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?

    enum CodingKeys: String, CodingKey {
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipcode = "zipcode"
        case geo = "geo"
    }
}

// MARK: - Geo
struct Geo: Codable {
    var lat: String?
    var lng: String?

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
}

// MARK: - Company
struct Company: Codable {
    var name: String?
    var catchPhrase: String?
    var bs: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }
}
