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
    
    init(json: JSON) {
        transactionID = json["transactionId"].stringValue
        date = json["date"].stringValue.toDate()
        cbTransactionTypeCode = json["cbTransactionTypeCode"].stringValue
        transactionDescription = json["description"].stringValue
        amount = json["amount"].stringValue
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        transactionID = try values.decodeIfPresent(String.self, forKey: .transactionID)
        date = try values.decodeIfPresent(Date.self, forKey: .date)
        cbTransactionTypeCode = try values.decodeIfPresent(String.self, forKey: .cbTransactionTypeCode)
        transactionDescription = try values.decodeIfPresent(String.self, forKey: .transactionDescription)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
    }
}


