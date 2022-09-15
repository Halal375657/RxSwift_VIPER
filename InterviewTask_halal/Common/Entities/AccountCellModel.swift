//
//  AccountTableViewModel.swift
//  InterviewTask_halal
//
//  Created by iOS on 14/9/22.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

struct AccountCellModel: Codable {
    var header: String
    var items: [Item]
}

extension AccountCellModel: SectionModelType {
    typealias Item = Transaction
    
    init(original: AccountCellModel, items: [Item]) {
        self = original
        self.items = items
    }
}
