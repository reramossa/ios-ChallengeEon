//
//  HomeModel.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 17/05/24.
//

import Foundation
struct HomeModel : Codable, Identifiable {
    var id = UUID()
    let meals : [Meals]?
    
    enum CodingKeys: String, CodingKey {
        case meals = "meals"
    }
}

struct Meals : Codable, Identifiable {
    var id = UUID()
    let idMeal : String?
    let strMeal : String?
    let strMealThumb : String?
    let strCategory: String?
    let strInstructions: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    
    
    enum CodingKeys: String, CodingKey {

        case idMeal = "idMeal"
        case strMeal = "strMeal"
        case strMealThumb = "strMealThumb"
        case strCategory = "strCategory"
        case strInstructions = "strInstructions"
        case strIngredient1 = "strIngredient1"
        case strIngredient2 = "strIngredient2"
        case strIngredient3 = "strIngredient3"
        case strIngredient4 = "strIngredient4"
        case strIngredient5 = "strIngredient5"
        case strIngredient6 = "strIngredient6"
        case strIngredient7 = "strIngredient7"
        case strIngredient8 = "strIngredient8"
        case strIngredient9 = "strIngredient9"
        case strIngredient10 = "strIngredient10"
    }
}
