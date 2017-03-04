//
//  Entry.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Unbox
import RealmSwift

class Entry: Object, Unboxable {
    
    dynamic var data : EntryData!
    dynamic var localId : String!
    
    // MARK: - Enums and Structs
    private struct JSONKey {
        static let localId = "databaseId"
        static let data = "data"
    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        
        data = unboxer.unbox(key: JSONKey.data)
        localId = unboxer.unbox(key: JSONKey.localId) ?? data.id
    }
    
    // MARK: - Realm
    override static func primaryKey() -> String? {
        return "localId"
    }
}
