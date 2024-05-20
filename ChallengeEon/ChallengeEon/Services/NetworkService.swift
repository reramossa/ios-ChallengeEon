//
//  NetworkService.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 18/05/24.
//

import Combine
import SwiftUI


class NetworkService {
    func fetchHome() -> AnyPublisher<HomeModel, Error> {
        let url = URL(string: getHomeUrl)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: HomeModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchCategories() -> AnyPublisher<CategoriesModel, Error> {
        let url = URL(string: getCategoriesUrl)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CategoriesModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchCategoriesDetail(meal: String) -> AnyPublisher<CategoriesDetailModel, Error> {
        let url = URL(string: getCategoriesDetailUrl + meal)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CategoriesDetailModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchMeals(idMeal: String) -> AnyPublisher<MealsModel, Error> {
        let url = URL(string: getMealsUrl + idMeal)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MealsModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
