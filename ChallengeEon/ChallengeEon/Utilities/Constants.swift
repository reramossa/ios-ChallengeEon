//
//  Constants.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 18/05/24.
//

import Foundation

public var getHomeUrl: String {
    return "https://www.themealdb.com/api/json/v1/1/random.php"
}

public var getCategoriesUrl: String {
    return "https://www.themealdb.com/api/json/v1/1/categories.php"
}

public var getCategoriesDetailUrl: String {
    return "https://www.themealdb.com/api/json/v1/1/filter.php?c="
}

public var getMealsUrl: String {
    return "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
}
