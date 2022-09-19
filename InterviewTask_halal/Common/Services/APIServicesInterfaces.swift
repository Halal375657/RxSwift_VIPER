//
//  APIServicesProtocol.swift
//  Viper
//
//  Created by Victor Alejandria on 12/09/2019.
//  Copyright © 2019 Victor Alejandria. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol APIServicesInterfaces {
    func getAccounts(apiRequest: APIRequest) -> Driver<Accounts>
    func getTransactions<T: Codable>(apiRequest: APIRequest) -> Observable<T>
}
