//
//  AlamofireService.swift
//  Tutorial
//
//  Created by Burak Dinç on 24.05.2022.
//

import Foundation
import Alamofire

struct AlamofireService {
    
    static let shared = AlamofireService()
    
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
     gönderebilirsiniz.
     */
    func getURLComponent() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https" // -> URL şeması
        urlComponents.host = "jsonplaceholder.typicode.com" // -> Base URL' imiz
        urlComponents.path = "/users" // -> Endpointimiz
        print("AlamofireService--> \(urlComponents.string!) adresine istek atılıyor...")
        return urlComponents
    }
    
    // MARK: - Methods
    
    /// Kullanıcı verilerini çekmek için atacağımız istek.
    func requestGetUsers() -> DataRequest {
        let request = self.getDefaultRequest(url: self.getURLComponent().string!,
                                             method: .get)
        return AF.request(request)
    }
    
}
