//
//  Services.swift
//  InterviewTask_halal
//
//  Created by iOS on 15/9/22.
//

import Foundation
import RxSwift
import RxCocoa

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
}
