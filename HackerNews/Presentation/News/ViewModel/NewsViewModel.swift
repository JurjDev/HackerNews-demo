//
//  NewsViewModel.swift
//  HackerNews
//
//  Created by JurjDev on 17/04/21.
//

import Foundation
import Core

class NewsViewModel {
    
    private var coreDataService: NewsCDService
    private var newsRepository: NewsRepositoryProtocol
    private var state: NewsState = .idle
    
    var showListSuccess = DelegateCall<Void>()
    var updateRefresh = DelegateCall<Void>()
    var showListError = DelegateCall<Void>()
    var updateList = DelegateCall<Void>()
    var news = [NewsItemViewModel]()
    
    init(newsRepository: NewsRepositoryProtocol,
         coreDataService: NewsCDService
         ) {
        self.newsRepository = newsRepository
        self.coreDataService = coreDataService
    }
    
    func loadData(type: loadingType) {
        if type == .firstTimeLoad {
            state = .loading
        }
        
        newsRepository.getNews { [weak self] result in
            guard let self = self
                else { return }
            
            switch result {
            case let .success(news):
                let entity = news.newsArticle.compactMap{ $0.toDomainModel() }
                self.news = self.saveList(news: entity)
                self.state = .success
                self.showListSuccess.callback?(())
                if type == .pullToRefresh {
                    self.updateRefresh.callback?(())
                }
            case .failure:
                self.state = .error
                if type == .pullToRefresh {
                    self.updateRefresh.callback?(())
                }
                self.loadListLocaly()
            }
        }
    }
    
    func removeData(at index: Int) {
        guard news.count > 0
            else { return }
        updateElement(state: false, news: news[index].newsArticle)
        news.remove(at: index)
        
        //news = news.filter { $0.newsArticle.visible == true }
        self.showListSuccess.callback?(())
    }
    
    private func saveList(news: [NewsEntity]) -> [NewsItemViewModel] {
        saveListLocaly(news: news)
        return news.map {
            let newsArticle = NewsArticleVM(
                id: $0.objectID,
                title: $0.title,
                author: $0.author,
                elapsed: DateFormat(withDate: $0.createdAt).description,
                url: $0.url,
                visible: true
            )
            return NewsItemViewModel(newsArticle: newsArticle)
        }
    }
    
    func saveListLocaly(news: [NewsEntity]) {
        let repository = coreDataService.newsCDRepository
        news.forEach{
            repository.createUnique(news: $0)
        }
        coreDataService.saveChanges()
    }
    
    func loadListLocaly() {
        let repository = coreDataService.newsCDRepository
        let predicate = NSPredicate(format: "id != 0 && visible == %@", NSNumber(booleanLiteral: true))
        let result = repository.getNews(predicate: predicate)
        
        switch result {
        case let .success(news):
            self.state = .success
            self.news = []
            self.news = saveList(news: news)
            self.showListSuccess.callback?(())
        case .failure(_):
            self.state = .error
            self.showListError.callback?(())
        }
    }
    
    func updateElement(state: Bool, news: NewsArticleVM) {
        let repository = coreDataService.newsCDRepository
        let predicate = NSPredicate(format: "id != 0 && id == %@", news.id)
        
        let result = repository.updateState(state: state, predicate: predicate)
        switch result {
        case let .success(updated):
            if updated {
                coreDataService.saveChanges()
            }
        case .failure(_): break
        }
    }
}

extension NewsViewModel {
    
    enum loadingType {
        
        case pullToRefresh
        
        case firstTimeLoad
    }
}
