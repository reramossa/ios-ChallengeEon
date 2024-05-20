//
//  MealsModel.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 20/05/24.
//

import Foundation
struct MealsModel : Codable, Identifiable {
    var id = UUID()
    let meals : [Meals]?
    
    enum CodingKeys: String, CodingKey {
        case meals = "meals"
    }
}
