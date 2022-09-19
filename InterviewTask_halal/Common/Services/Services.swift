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
    
    /**
     `Driver<Accounts>` can be considered a builder pattern for observable sequences that drive the application.
     
     If observable sequence has produced at least one element, after new subscription is made last produced element will be
     immediately replayed on the same thread on which the subscription was made.
     
     When using `drive*`, `subscribe*` and `bind*` family of methods, they should always be called from main thread.
     
     If `drive*`, `subscribe*` and `bind*` are called from background thread, it is possible that initial replay
     will happen on background thread, and subsequent events will arrive on main thread.
     
     - parameters:
     - returns : `Driver<Accounts>` bulder pattern
     */
    func getAccounts(apiRequest: APIRequest) -> Driver<Accounts> {
        let urlRequest = URLRequest(url: apiRequest.url)
        let result:Driver<Accounts> = remoteStream(urlRequest)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .single()
            .asDriver(onErrorJustReturn: Accounts())
        
        return result
    }
    
    
    /**
     The `Observable<T>` is represents a push style sequence.
     
     It is possible that events are sent from different threads, but no two events can be sent concurrently to
     `observer`.
     
     - parameter apiRequest: `APIRequest` Type.
     - returns `Observable<T>` sequence.
     */
    func getTransactions<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
#warning("The `Transaction Listing` API response data should change a few things from the backend. Please make change the responsed data type. It's right now okay, I handle it manually. Although I can handle it using another approach - I could detect the `amount` data type using `decode` method by creating `enum`(string,integer) but I didn't it. because at this moment I'm not fully confindent on backend😀☺️. that's why I'm trying to stay in safe zone!")
        
        return Observable<T>.create { observar in
            let request = apiRequest.request(with: apiRequest.url)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let data = data else {observar.onError(error!); return }
                
                /**
                 The inner method function praparing the fetched data for load to `Transactions Listing` Table view.
                 
                 - returns: The prepared `AccountCellModel` array.
                 */
                func praparingTheTableViewData() -> Array<AccountCellModel>{
                    /// table header view data - it's inserted in first of the table view data-source.
                    let headerViewData = AccountCellModel(header: "", items: [Transaction(json: JSON())])
                    return [headerViewData] + Dictionary(
                        grouping: JSON(data)["transactions"]
                            .compactMap { (_, transaction) in
                                return Transaction(json: transaction)
                            }) { (transaction) -> Date in
                                return transaction.date!
                            }.sorted { $0.key < $1.key }
                        .compactMap { (key: Date, value: [Transaction]) in
                            AccountCellModel(
                                header: key.toString(),
                                items: value
                            )
                        }
                }
                
                observar.onNext(praparingTheTableViewData() as! T)
                observar.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
