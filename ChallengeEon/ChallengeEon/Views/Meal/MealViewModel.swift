//
//  MealViewModel.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 20/05/24.
//


import Foundation
import Combine

final class MealViewModel: ObservableObject {
    @Published private(set) var state: State
    private let networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    let idMeal: String
    
    enum Event {
        case viewAppeared
    }

    enum State {
        case loading
        case loaded(LoadedState)
    }

    struct LoadedState {
        let meals: MealsModel
    }

    
    init(idMeal: String, state: State = .loading) {
        self.idMeal = idMeal
        self.state = state
    }
    
    public func send(_ event: Event) {
        switch event {
        case .viewAppeared:
            loadMeals()
        }
    }
}


private extension MealViewModel {

    func loadMeals() {
        Task { @MainActor in
            networkService.fetchMeals(idMeal: idMeal)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error al cargar: \(error)")
                    }
                }, receiveValue: { mealsModel in
                    DispatchQueue.main.async{
                        self.state = .loaded(LoadedState(meals: mealsModel))
                      }
                })
                .store(in: &cancellables)
        }
    }
}


