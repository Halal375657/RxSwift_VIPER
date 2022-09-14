//
//  Transactions.swift
//  RxSwiftDemo
//
//  Created by iOS on 13/9/22.
//
import Foundation
import SwiftyJSON


// MARK: - Transactions
struct Transactions: Codable {
    let accountNumber: String?
    let transactions: [Transaction]
}

// MARK: - Transaction
struct Transaction: Codable {
    let transactionID: String?
    let date: Date?
    let cbTransactionTypeCode, transactionDescription, amount: String?

    enum CodingKeys: String, CodingKey {
        case transactionID = "transactionId"
        case date, cbTransactionTypeCode
        case transactionDescription = "description"
        case amount
    }
}


