//
//  CategoriesDetailViewModel.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 19/05/24.
//

import Foundation
import Combine

final class CategoriesDetailViewModel: ObservableObject {
    @Published private(set) var state: State
    private let networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    let strCategory: String
    
    enum Event {
        case viewAppeared
    }

    enum State {
        case loading
        case loaded(LoadedState)
    }

    struct LoadedState {
        let categoriesDetail: CategoriesDetailModel
    }

    
    init(strCategory: String, state: State = .loading) {
        self.strCategory = strCategory
        self.state = state
    }
    
    public func send(_ event: Event) {
        switch event {
        case .viewAppeared:
            loadCategoriesDetail()
        }
    }
}


private extension CategoriesDetailViewModel {

    func loadCategoriesDetail() {
        Task { @MainActor in
            networkService.fetchCategoriesDetail(meal: strCategory)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error al cargar: \(error)")
                    }
                }, receiveValue: { categoriesModel in
                    DispatchQueue.main.async{
                        self.state = .loaded(LoadedState(categoriesDetail: categoriesModel))
                      }
                })
                .store(in: &cancellables)
        }
    }
}

