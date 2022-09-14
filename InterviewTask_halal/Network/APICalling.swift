//
//  APICalling.swift
//  RxSwiftDemo
//
//  Created by iOS on 12/9/22.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class APICalling {
    
    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        
        return Observable<T>.create { observar in
            let request = apiRequest.request(with: apiRequest.url)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let model: Accounts = try JSONDecoder().decode(Accounts.self, from: data ?? Data())
                    observar.onNext(model.accounts as! T)
                } catch let error {
                    observar.onError(error)
                }
                observar.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

class APICalling1 {
    
    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        
        return Observable<T>.create { observar in
            let request = apiRequest.request(with: apiRequest.url)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let data = data else {observar.onError(error!); return }
                
                var dic = Dictionary(
                    grouping: JSON(data)["transactions"]
                        .compactMap { (_, transaction) in
                    return transaction.getTransaction()
                }) { (transaction) -> Date in
                    return transaction.date!
                }.sorted { $0.key < $1.key }
                 .compactMap { (key: Date, value: [Transaction]) in
                     AccountCellModel(
                         header: key.toString(),
                         items: value
                     )
                 }
                
                /// for handle the table view header view.
                dic.insert(AccountCellModel(header: "", items: [Transaction(transactionID: nil, date: nil, cbTransactionTypeCode: nil, transactionDescription: nil, amount: nil)]), at: 0)
                
                observar.onNext(dic as! T)
                observar.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
} 
