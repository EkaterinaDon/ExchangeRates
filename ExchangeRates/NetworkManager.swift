//
//  NetworkManager.swift
//  ExchangeRates
//
//  Created by Ekaterina on 4.07.21.
//

import Foundation
import Alamofire

class NetworkManager {
    
    var rates: [Rate] = []
    
    let baseUrl = URL(string: "https://alpha.as50464.net:29870/moby-pre-44/core?r=BEYkZbmV&d=563B4852-6D4B-49D6-A86E-B273DD520FD2&t=ExchangeRates&v=44")
    
    let headers: HTTPHeaders = ["User-Agent":"Test GeekBrains iOS 3.0.0.182 (iPhone 11; iOS 14.4.1; Scale/2.00; Private)",
                                "Content-Type":"application/json",
                                "Accept":"application/json"]
    
    let parameters: [String: Any] = [
        "uid" : "563B4852-6D4B-49D6-A86E-B273DD520FD2",
        "type" : "ExchangeRates",
        "rid" : "BEYkZbmV",
    ]

    func getRates(completion: @escaping (([Rate]) -> Void)) {
        if let url = baseUrl {
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
                switch response.result {
                case.success(let data):
                    do {
                        let rates = try JSONDecoder().decode(ExchangeModel.self, from: data).rates
                        completion(rates!)
                    } catch let error as NSError {
                        debugPrint(error.localizedDescription)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
}
