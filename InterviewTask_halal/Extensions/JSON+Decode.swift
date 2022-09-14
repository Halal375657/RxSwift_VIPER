//
//  JSON+Decode.swift
//  InterviewTask_halal
//
//  Created by iOS on 14/9/22.
//

import Foundation
import SwiftyJSON

extension JSON {
    func getTransaction() -> Transaction {
        return Transaction(
            transactionID: self["transactionId"].stringValue,
            date: self["date"].stringValue.toDate(),
            cbTransactionTypeCode: self["cbTransactionTypeCode"].stringValue,
            transactionDescription: self["description"].stringValue,
            amount: self["amount"].stringValue
        )
    }
}
