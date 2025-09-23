//
//  Diary.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/23/25.
//

import Foundation
import RealmSwift

class Diary: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var memo: String
    @Persisted var favorite: Bool
    
    convenience init(name: String, content: String) {
        self.init()
        self.name = name
        self.memo = content
        self.favorite = false
    }
}

//class Diary2: Object {
//    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted var name: String
//    @Persisted var content: String
//    @Persisted var favorite: Bool
//}
