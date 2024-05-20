//
//  CategoriesViewModel.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 19/05/24.
//


import Foundation
import Combine

final class CategoriesViewModel: ObservableObject {
    
    @Published private(set) var state: State
    private let networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()

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
                        self.state = .loaded(LoadedState(categories: categoriesModel))
                      }
                })
                .store(in: &cancellables)
        }
    }
}


