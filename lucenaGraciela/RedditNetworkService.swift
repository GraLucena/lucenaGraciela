//
//  RedditNetworkService.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Unbox

struct RedditNetworkService {

struct Key {
    static let data = "data"
    static let children = "children"
}

    static func topReddits(page: String) -> Observable<[Entry]>{
    
    return Observable.create { (observer) -> Disposable in
        
        Alamofire.request(Router.getTop(page))
            .validate()
            .responseData { (response) in
                
                switch response.result {
                case .success(let jsonData):
                    
                    
                    if let jsonDictionary = jsonData.toJSONDictionary(), let dataJSON = jsonDictionary[Key.data] as? jsonDictionary{
                        UserDefaults.standard.setValue(dataJSON["after"], forKey: "next_page")
                    }
                    
                    guard let jsonDictionary = jsonData.toJSONDictionary(), let dataJSON = jsonDictionary[Key.data] as? jsonDictionary, let reddits: [Entry] = try? unbox(dictionary: dataJSON, atKey: Key.children) else {
                        observer.onError(ApiError.defaultError)
                        break
                    }
                    
                    observer.onNext(reddits)
                    observer.onCompleted()
                    
                case .failure(let error):
                    let apiError = ApiError(error: error, data:  response.data) ?? .defaultError
                    observer.onError(apiError)
                }
        }
        
        return Disposables.create()
    }
}
}
