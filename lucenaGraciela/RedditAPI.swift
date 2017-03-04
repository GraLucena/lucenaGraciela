//
//  RedditAPI.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

struct RedditAPI {
    
    private static let disposeBag = DisposeBag()
    
    static func readEntries(page: String) -> Observable<[Entry]> {
        
        RedditNetworkService.topReddits(page: page)
            .subscribe(onNext: { (entries) in
                saveEntries(entries: entries)
                    .subscribe()
                    .addDisposableTo(disposeBag)
            })
            .addDisposableTo(disposeBag)

        return RedditDiskService.readReddits()
    }
    
    
    private static func saveEntries(entries: [Entry]) -> Observable<Bool> {
        return RedditDiskService.save(entries: Array(entries))
    }
    
    
}
