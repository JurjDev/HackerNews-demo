//
//  NewsArticleViewModel.swift
//  HackerNews
//
//  Created by JurjDev on 17/04/21.
//

import Foundation

class NewsArticleVM {
    
    let id: String
    
    let title: String
    
    let author: String
    
    let elapsed: String
    
    let url: String?
    
    var visible: Bool
    
    init(id: String,
         title: String,
         author: String,
         elapsed: String,
         url: String?,
         visible: Bool = true) {
        
        self.id = id
        self.title = title
        self.author = author
        self.elapsed = elapsed
        self.url = url
        self.visible = visible
    }
}
