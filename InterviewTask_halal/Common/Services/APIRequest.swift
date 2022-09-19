//
//  APIRequest.swift
//  RxSwiftDemo
//
//  Created by iOS on 12/9/22.
//

import Foundation

class APIRequest {
    var url: URL
    var method = RequestType.GET
    var parameters = [String: String]()
    
    /**
     preparing the `URLRequest` accorting to give url.
     
     - parameters:
      - baseURL: targeted url that type is `URL`.
     - returns: Manipulated `URLRequest`
     */
    func request(with baseURL: URL) -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    /// - parameter urlString: `String` of the url
    init(urlString: String) {
        self.url = URL(string: urlString)!
    }
        
}
