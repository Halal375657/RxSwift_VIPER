//
//  Services.swift
//  InterviewTask_halal
//
//  Created by iOS on 15/9/22.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

final class Services: BaseServices, APIServicesInterfaces {
    
    func getAccounts() -> Driver<Accounts> {
        let components = URLComponents(string: Constants.API.URLBase.appendingPathComponent("5abb1042350000580073a7ea").absoluteString)!
        let urlRequest = URLRequest(url: components.url!)
        let result:Driver<Accounts> = remoteStream(urlRequest)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .single()
            .asDriver(onErrorJustReturn: Accounts())
        
        return result
    }
    
    func getTransactions<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        
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
