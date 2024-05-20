//
//  CategoriesModel.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 18/05/24.
//

import Foundation
struct CategoriesModel : Codable, Identifiable {
    var id = UUID()
    let categories : [Categorie]?
    
    enum CodingKeys: String, CodingKey {
        case categories = "categories"
    }
}

struct Categorie : Codable, Identifiable {
    var id = UUID()
    let idCategory : String?
    let strCategory : String?
    let strCategoryDescription : String?
    let strCategoryThumb : String?
    
    
    enum CodingKeys: String, CodingKey {
        case idCategory = "idCategory"
        case strCategory = "strCategory"
        case strCategoryDescription = "strCategoryDescription"
        case strCategoryThumb = "strCategoryThumb"
    }
}

