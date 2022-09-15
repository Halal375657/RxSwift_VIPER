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
    func getAccounts() -> Driver<Accounts>
    func getTransactions<T: Codable>(apiRequest: APIRequest) -> Observable<T>
    
//    func getUsersBy(id: Int) -> Driver<ServicesUser>
//    func getAlbumsBy(user: Int) -> Driver<[Album]>
//    func getAlbumBy(id: Int) -> Driver<Album>
//    func getPhotosBy(album: Int) -> Driver<[Photo]>
//	func downloadImageDataFrom(url: String) -> Driver<Data>
}
