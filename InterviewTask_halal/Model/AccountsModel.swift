//
//  AccountsModel.swift
//  RxSwiftDemo
//
//  Created by iOS on 12/9/22.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

// MARK: - Accounts
struct Accounts: Codable {
    let accounts: [Account]?
    
    private enum CodingKeys: String, CodingKey {
        case accounts
    }
}

// MARK: - Account
struct Account: Codable {
    let accountNumber, accountBSB, accountLabel, currentBalance: String?
    let availableBalance: String?
    let transactions: String?

    enum CodingKeys: String, CodingKey {
        case accountNumber
        case accountBSB = "accountBsb"
        case accountLabel, currentBalance, availableBalance, transactions
    }
}
