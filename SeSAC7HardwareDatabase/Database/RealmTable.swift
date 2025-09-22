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
    
    @Persisted var detail: List<Account> //폴더 테이블 안에 account 테이블이 들어 있는 구조
    
    @Persisted var memo: Memo? //항상 옵셔널 선언. Memo 테이블이 생기지는 않음.
    
    convenience init(name: String) {
        self.init()
        
        self.name = name
        self.regdate = Date()
    }
}

//To-One Realationship
class Memo: EmbeddedObject {
    @Persisted var memoContents: String
    @Persisted var memoMusic: String
    @Persisted var regDate: Date
    @Persisted var editDate: Date
}

class Account: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var money: Int
    @Persisted var title: String
    
    //Inverse Relationship
    @Persisted(originProperty: "detail")
    var folder: LinkingObjects<MoneyFolder>
    
    convenience init(title: String) {
        self.init()
        self.money = Int.random(in: 1...1000) * 100
        self.title = title
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
