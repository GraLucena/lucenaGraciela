//
//  DataResponse.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Unbox
import RealmSwift

class DataResponse: Unboxable {
    
    var data = List<Entry>()
    dynamic var after : String!
    
    // MARK: - Enums and Structs
    private struct JSONKey {
        static let data = "data"
        static let after = "after"
    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        
        let entries: [Entry]? = unboxer.unbox(key: JSONKey.data)
        if entries != nil {
            self.data = List(entries!)
        }
        after = unboxer.unbox(key: JSONKey.after)
    }
}
