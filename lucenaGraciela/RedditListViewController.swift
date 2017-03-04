//
//  RedditListViewController.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit
import RxSwift
import CellRegistrable
import SVProgressHUD

class RedditListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    fileprivate let disposeBag = DisposeBag()
    fileprivate var entries = [Entry]()
    var viewModel: RedditListViewModel

    // MARK: - Init
    init(viewModel: RedditListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: RedditListViewController.self), bundle: nil)
        viewModel.viewDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Reddits"
        SVProgressHUD.show()
        configureTable()
        // Do any additional setup after loading the view.
    }
    
    private func configureTable() {
        tableView.registerCell(RedditTableViewCell.self)
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        viewModel.getTopItems(page: "")
    }    
}

//MARK: - UITableViewDelegate
extension RedditListViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let nextPage = UserDefaults.standard.value(forKey: "next_page"){
                if(indexPath.row == viewModel.numberOfTopItems() - 1){
                    viewModel.getTopItems(page: nextPage as! String)
                }
        }
    }
}



//MARK: - UITableViewDataSource
extension RedditListViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTopItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RedditTableViewCell.reuseIdentifier, for: indexPath as IndexPath)
        
        if let entryCell = cell as? RedditTableViewCell{
            let item = viewModel.itemAt(indexPath.row)
            
            entryCell.title.text = item.data.title
            entryCell.author.text = item.data.author
            entryCell.comments.text = String(item.data.comments)
            entryCell.subreddit.text = item.data.subreddit
            let dateCreated = Date(timeIntervalSince1970: TimeInterval(item.data.date))
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            entryCell.date.text = formatter.string(from: dateCreated)
            if let image = item.data.image, let URLimage = URL(string: image){
                entryCell.thumbnail.loadImage(with: URLimage, placeholderImage: UIImage(named: "ic_placeholder"))
            }
        }
        return cell
    }
}

// MARK: - RedditListViewModelViewDelegate
extension RedditListViewController: RedditListViewModelViewDelegate{
    func topItemsDidChange(viewModel: RedditListViewModel) {
        tableView.reloadData()
        SVProgressHUD.dismiss()
    }
    
    func showAlertError(viewModel: RedditListViewModel, error: ApiError) {
        SVProgressHUD.dismiss()
        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: LocalizableString.ok.localizedString, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
