//
//  FavouritesViewController.swift
//  Headlines
//
//  Created by Joshua Garnham on 09/05/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import SDWebImage

class SubtitleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class FavouritesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var articleSelected: ((IndexPath) -> Void)?
   
    var viewModel: FavouritesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        
        tableView.register(UINib(nibName: String(describing: SingleArticleTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SingleArticleTableViewCell.self))
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        viewModel.delegate = self
    }
    
    @objc func doneButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension FavouritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTable(query: searchText)
    }
}
extension FavouritesViewController: FavouritesViewModelDelegate {
    func reloadTable() {
        tableView.reloadData()
    }
}

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.item(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: SingleArticleTableViewCell.self), for: indexPath)
        (cell as? SingleArticleTableViewCell)?.configureView(article: article)
        let date = viewModel.formatDate(dateString: article.published)
        (cell as? SingleArticleTableViewCell)?.configureDate(date: date)
        return cell
    }
}
