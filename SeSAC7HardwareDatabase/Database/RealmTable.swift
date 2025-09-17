//
//  RealmTable.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/17/25.
//

import Foundation
import RealmSwift

class MoneyTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var type: Bool
    @Persisted var money: Int
    @Persisted var date: Date
    @Persisted var category: Int //0: 식비, 1: 생활비, 2: 적금
    
    @Persisted var place: String?
    @Persisted var memo: String?
    @Persisted var card: Bool? //카드 true, 현금 false
    
    convenience init(type: Bool, money: Int, useDate: Date, category: Int, place: String? = nil, memo: String? = nil, card: Bool? = nil) {
        self.init()
        
        self.type = type
        self.money = money
        self.date = useDate
        self.category = category
        self.place = place
        self.memo = memo
        self.card = card
    }
}
