//
//  RedditDiskService.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm
import Unbox

struct RedditDiskService {
    
    private static let disposeBag = DisposeBag()
    
    // MARK: - Properties
    private static var realm: Realm {
        return try! Realm()
    }
    
    // MARK: - API
    static func readReddits() -> Observable<[Entry]> {
        
        let realmEntries = realm.objects(Entry.self)
        
        return Observable.array(from: realmEntries)
            .map { array in
                return array
        }
    }
    
    static func save(entries: [Entry]) -> Observable<Bool> {
        
        do {
            realm.beginWrite()
            realm.add(entries, update: true)
            try realm.commitWrite()
            return Observable.just(true)
        } catch {
            return Observable.just(false)
        }
    }
    
}
