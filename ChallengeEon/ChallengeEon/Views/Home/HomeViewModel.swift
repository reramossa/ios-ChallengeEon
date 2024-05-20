//
//  HomeViewModel.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 17/05/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published private(set) var state: State
    private let networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    private var meals : [Meals] = []
    private var elementsCount = 0

    enum Event {
        case viewAppeared
        case mealTapped(Meals)
    }

    enum State {
        case loading
        case loaded(LoadedState)
    }

    struct LoadedState {
        let meals: HomeModel
    }

    

    init(state: State = .loading) {
        self.state = state
    }

    public func send(_ event: Event) {
        switch event {
        case .viewAppeared:
            loadUsers()
        case .mealTapped(let meal):
            mealTapped(meal)
        }
    }
}

private extension HomeViewModel {

    func loadUsers() {
        Task { @MainActor in
            networkService.fetchHome()
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error al cargar: \(error)")
                    }
                }, receiveValue: { homeModel in
                    print(2)
                    DispatchQueue.main.async{
                        if let meal = homeModel.meals {
                            self.meals.append(contentsOf: meal)
                        }
                        self.elementsCount = self.elementsCount + 1
                        if self.elementsCount == 3 {
                            self.state = .loaded(LoadedState(meals: HomeModel(meals: self.meals)))
                        } else {
                            self.loadUsers()
                        }
                      }
                })
                .store(in: &cancellables)
        }
    }

    func mealTapped(_ meals: Meals) {
    }
}

