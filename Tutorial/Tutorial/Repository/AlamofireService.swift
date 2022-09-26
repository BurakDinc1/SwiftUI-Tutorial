//
//  AlamofireService.swift
//  Tutorial
//
//  Created by Burak Dinç on 24.05.2022.
//

import Foundation
import Alamofire

struct AlamofireService {
    
    public static let shared = AlamofireService()
    
    // Default Request
    /*
     url --> İstek atılacak URL
     method --> İstek atılan metodun tipini veriyoruz (Örn.: GET, POST)
     params --> İstek atılan metoda body içerisinde göndereceğimiz parametrelemerimiz
    */
    func getDefaultRequest(url: String,
                           method: HTTPMethod,
                           params: [String: AnyObject] = [:]) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData // -> Cache politikası
        request.timeoutInterval = 120.0 // -> İstek zaman aşımı
        request.method = method
        if(!params.isEmpty) { // -> Eğer bu fonksiyona bir parametre gönderiliyorsa bunu body içerisine ekliyoruz.
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }
        return request
    }
    
    // Default URL Component
    /*
     Bu method özelinde eğer projeniz kapsamlı bir proje ise bir URLPath sınıfı oluşturup
     bu sınıf içerisinde endpointlerinizi tanımlayabilir ve bu methoda parametre olarak
     gönderebilirsiniz. Bunun temel sebebi proje icerisinde urllerinizi bir standarda
     oturtmak.
     */
    func getURLComponent() -> String {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https" // -> URL şeması
        urlComponents.host = "jsonplaceholder.typicode.com" // -> Base URL' imiz
        urlComponents.path = "/users" // -> Endpointimiz
//        urlComponents.queryItems = [URLQueryItem(name: "page", value: "1")] // -> Servislerinize query parametresi ekleyebilirsiniz.
        print("AlamofireService--> \(urlComponents.string!) adresine istek atılıyor...")
        return urlComponents.string!
    }
    
    // MARK: - Methods
    
    /// Kullanici verilerini cekmek icin atacagimiz istek.
    /// Eski kullanimi
    public func requestGetUsers() -> DataRequest {
        let request = self.getDefaultRequest(url: self.getURLComponent(),
                                             method: .get)
        return AF.request(request)
    }
    
    /// Kullanici verilerini cekmek icin alternatif istek turu
    /// Extension uzerinden takip edebilirsin.
    /// Hata ayiklamalarini kendi servislerinize gore
    /// duzenleyebilirsiniz.
    public func requestGetUsersAlternative(completion: @escaping (WSResult<[GetUserResponse]>) -> Void) {
        AF.request(self.getURLComponent(),
                   method: .get)
        .fetchServiceWithErrorHandling { result in
            completion(result)
        }
    }
    
}
