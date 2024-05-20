//
//  CategoriesDetailModel.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 19/05/24.
//

import Foundation
struct CategoriesDetailModel : Codable, Identifiable {
    var id = UUID()
    let meals : [Meals]?
    
    enum CodingKeys: String, CodingKey {
        case meals = "meals"
    }
}
