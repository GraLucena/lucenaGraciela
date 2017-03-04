//
//  RedditListViewModel.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import RxSwift

protocol RedditListViewModelViewDelegate: class {
    func topItemsDidChange(viewModel: RedditListViewModel)
    func showAlertError(viewModel: RedditListViewModel, error: ApiError)
}

protocol RedditListViewModel: class {

    var viewDelegate: RedditListViewModelViewDelegate? { get set }

    var topItems: [Entry]? { get set }

    func getTopItems(page: String)
    func numberOfTopItems() -> Int
    func itemAt(_ index: Int) -> Entry

    
}

class RedditListAPIViewModel: RedditListViewModel {

    var viewDelegate: RedditListViewModelViewDelegate?

    fileprivate let disposeBag = DisposeBag()

    var topItems: [Entry]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.viewDelegate?.topItemsDidChange(viewModel: strongSelf)
            }
        }
    }

    func getTopItems(page: String) {
        RedditAPI.readEntries(page: page)
            .do(onNext: { (entries) in
                if page != ""{
                    var newData = self.topItems
                    newData?.append(contentsOf: entries)
                    self.topItems = newData
                }else{
                    self.topItems = entries
                }
            }, onError: { (error) in
                let error = error as? ApiError ?? ApiError.defaultError
                self.viewDelegate?.showAlertError(viewModel: self, error: error)
            })
            .subscribe()
            .addDisposableTo(disposeBag)
    }
    
    func numberOfTopItems() -> Int {
        return topItems?.count ?? 0
    }

    func itemAt(_ index: Int) -> Entry{
        return (topItems?[index])!
    }
}
