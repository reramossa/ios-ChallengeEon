//
//  CategoriesViewModel.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 19/05/24.
//


import Foundation
import Combine
import CoreData

final class CategoriesViewModel: ObservableObject {
    
    @Published private(set) var state: State
    private let networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    
    private let manager = PersistenceController()

    enum Event {
        case viewAppeared
    }

    enum State {
        case loading
        case loaded(LoadedState)
    }

    struct LoadedState {
        let categories: CategoriesModel
    }

    init(state: State = .loading) {
        self.state = state
    }

    public func send(_ event: Event) {
        switch event {
        case .viewAppeared:
            loadCategories()
        }
    }
}

private extension CategoriesViewModel {

    func loadCategories() {
        Task { @MainActor in
            let categoriesCoreData = getCategoriesCoreData()
            
            if !categoriesCoreData.isEmpty {
                self.state = .loaded(LoadedState(categories: CategoriesModel(categories: categoriesCoreData)))
            } else {
                networkService.fetchCategories()
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            print("Error al cargar: \(error)")
                        }
                    }, receiveValue: { categoriesModel in
                        DispatchQueue.main.async{
                            self.saveCategori(categories: categoriesModel)
                            self.state = .loaded(LoadedState(categories: categoriesModel))
                          }
                    })
                    .store(in: &cancellables)
            }
        }
    }
    
    func saveCategori(categories: CategoriesModel?) {
        guard let categories = categories?.categories else { return }
        for categorieCD in categories {
            manager.createCategorie(categories: categorieCD) {}
        }
    }
    
    func getCategoriesCoreData() -> [Categorie] {
        
        var categories: [Categorie] = []
        let categoriesCD = manager.getCategoriesCoreData()
        for categori in categoriesCD {
            categories.append(Categorie(idCategory: categori.idCategory,
                                        strCategory: categori.strCategory,
                                        strCategoryDescription: categori.strCategoryDescription,
                                        strCategoryThumb: categori.strCategoryThumb))
            
        }
        return categories
    }
}


