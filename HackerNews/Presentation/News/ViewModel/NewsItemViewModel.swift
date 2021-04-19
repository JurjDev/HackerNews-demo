//
//  NewsItemViewModel.swift
//  HackerNews
//
//  Created by JurjDev on 17/04/21.
//

import Foundation
import UIKit

protocol ItemViewModel {
    
    var reuseIdentifier: String { get }
    
    func setUp(_ cell: UITableViewCell)
}

struct NewsItemViewModel: ItemViewModel  {
    
    var reuseIdentifier: String { return Strings.Cell.id }
    
    var newsArticle: NewsArticleVM
    
    init(newsArticle: NewsArticleVM) {
        self.newsArticle = newsArticle
    }
    
    func setUp(_ cell: UITableViewCell) {
        guard let cell = cell as? NewsTableViewCell
            else { return }
        cell.newsTitle.text = newsArticle.title
        cell.newsData.text = newsArticle.author + " - " + newsArticle.elapsed
    }
}
