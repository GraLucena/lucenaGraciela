//
//  EntryData.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Unbox
import RealmSwift

class EntryData: Object, Unboxable {
    
    dynamic var id : String!
    dynamic var title : String!
    dynamic var author : String!
    dynamic var comments : Int = 0
    dynamic var subreddit : String!
    dynamic var image : String?
    dynamic var date : Int = 0

    // MARK: - Enums and Structs
    private struct JSONKey {
        static let id = "id"
        static let title = "title"
        static let author = "author"
        static let comments = "num_comments"
        static let subreddit = "subreddit_type"
        static let image = "thumbnail"
        static let date = "created"

    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        
        id = unboxer.unbox(key: JSONKey.id)
        title = unboxer.unbox(key: JSONKey.title)
        author = unboxer.unbox(key: JSONKey.author)
        comments = unboxer.unbox(key: JSONKey.comments) ?? 0
        subreddit = unboxer.unbox(key: JSONKey.subreddit)
        image = unboxer.unbox(key: JSONKey.image)
        date = unboxer.unbox(key: JSONKey.date) ?? 0
    }
    
    // MARK: - Realm
    override static func primaryKey() -> String? {
        return "id"
    }
}
