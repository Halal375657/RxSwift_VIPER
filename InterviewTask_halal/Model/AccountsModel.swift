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
    
    init() {
        accounts = []
    }
    
    private enum CodingKeys: String, CodingKey {
        case accounts
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accounts = try values.decodeIfPresent(Array<Account>.self, forKey: .accounts)
    }
}

// MARK: - Account
struct Account: Codable {
    let accountNumber, accountBSB, accountLabel, currentBalance: String?
    let availableBalance: String?
    let transactions: String?
    
    init() {
        accountNumber = ""
        accountBSB = ""
        accountLabel = ""
        currentBalance = ""
        availableBalance = ""
        transactions = ""
    }

    enum CodingKeys: String, CodingKey {
        case accountNumber
        case accountBSB = "accountBsb"
        case accountLabel, currentBalance, availableBalance, transactions
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountNumber = try values.decodeIfPresent(String.self, forKey: .accountNumber)
        accountBSB = try values.decodeIfPresent(String.self, forKey: .accountBSB)
        accountLabel = try values.decodeIfPresent(String.self, forKey: .accountLabel)
        currentBalance = try values.decodeIfPresent(String.self, forKey: .currentBalance)
        availableBalance = try values.decodeIfPresent(String.self, forKey: .availableBalance)
        transactions = try values.decodeIfPresent(String.self, forKey: .transactions)
    }
    
}
