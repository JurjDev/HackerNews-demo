//
//  HackerNewsViewController.swift
//  HackerNews
//
//  Created by JurjDev on 15/04/21.
//

import UIKit
import Core

final class HackerNewsViewController: UITableViewController {
    
    // MARK: - properties
    
    var selectedIndexPath: IndexPath!

    lazy var viewModel: NewsViewModel = {
        let transferService = AppContainer.shared.dataTransferService
        let newsRepository = NewsRepository(transferServices: transferService)
        let coreDataService = NewsCDService(context: CoreDataServices.shared.persistendContainer.viewContext)
        return NewsViewModel(newsRepository: newsRepository, coreDataService: coreDataService)
    }()
}

// MARK: - Life Cycle

extension HackerNewsViewController {
    
    override func viewDidLoad() {
        setUpTableView()
        setUpBindings()
        viewModel.loadData(type: .firstTimeLoad)
    }
}

// MARK: - Set Up

extension HackerNewsViewController {
    
    func setUpTableView() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: Strings.TableView.refresh)
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    func setUpBindings() {
        
        viewModel.showListSuccess.delegate(to: self) { (self, _) in
            self.tableView.reloadData()
        }
        
        viewModel.updateRefresh.delegate(to: self) { (self, _) in
            self.refreshControl?.endRefreshing()
        }
    }
    
    @objc func refreshNews(_ sender: UIRefreshControl) {
        
        viewModel.loadData(type: .pullToRefresh)
    }
}

// MARK: - Navigation

private extension HackerNewsViewController {
    
    func showNewsDetail() {
        
        let article = viewModel.news[selectedIndexPath.row].newsArticle
        guard let url = URL(string: article.url ?? "")
            else { return }
        
        let newsDetail = WebViewViewController.instance()
        newsDetail.url = url
        navigationController?.pushViewController(newsDetail, animated: true)
    }
}

// MARK: - TableView Data Source Methods

extension HackerNewsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.Cell.id, for: indexPath)
        self.viewModel.news[indexPath.row].setUp(cell)
        return cell
    }
}

// MARK: - TableView Delegate Methods

extension HackerNewsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.showNewsDetail()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.removeData(at: indexPath.row)
        }
    }
}

extension HackerNewsViewController: InstantiableController {
    
    static func instance() -> HackerNewsViewController {
        
        let storyboard = UIStoryboard(name: Strings.News.storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Strings.News.storyboardId) as! HackerNewsViewController
        return vc
    }
}
