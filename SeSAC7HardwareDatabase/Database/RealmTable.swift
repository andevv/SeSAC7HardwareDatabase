//
//  RealmTable.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/17/25.
//

import Foundation
import RealmSwift

class MoneyFolder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String
    @Persisted var regdate: Date
    
    convenience init(name: String) {
        self.init()
        
        self.name = name
        self.regdate = Date()
    }
}

class MoneyTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var folder: ObjectId //어떤 폴더인지
    
    @Persisted var type: Bool
    @Persisted var money: Int
    @Persisted var date: Date
    @Persisted var category: Int //0: 식비, 1: 생활비, 2: 적금
    
    @Persisted var title: String?
    @Persisted var place: String?
    @Persisted(indexed: true) var memo: String?
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
