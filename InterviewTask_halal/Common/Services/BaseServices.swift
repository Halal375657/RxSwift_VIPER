//
//  BaseServices.swift
//  InterviewTask_halal
//
//  Created by iOS on 15/9/22.
//

import Foundation
import RxCocoa
import RxSwift

class BaseServices {
    
    static let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
    
    func remoteData(_ request: URLRequest) -> Observable<Data> {
        return URLSession.shared.rx.response(request: request)
            .map{ return $1    }
    }

    func remoteStream<T: Codable>(_ request: URLRequest) -> Observable<T> {
        return URLSession.shared.rx.response(request: request)
            .map{ (_, data) in
                guard let record: T = try? JSONDecoder().decode(T.self, from: data) else { throw VIPERError.decodingJSON }
                return record
        }
    }
    
    func remoteArrayStream<T: Codable>(_ request: URLRequest) -> Observable<[T]> {
        return URLSession.shared.rx.response(request: request)
            .map{ (_, data) in
                guard let records: [T] = try? JSONDecoder().decode(Array<T>.self, from: data) else { throw VIPERError.decodingJSON }
                return records
        }
    }
}
