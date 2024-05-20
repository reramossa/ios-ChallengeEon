//
//  Meal.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 19/05/24.
//

import SwiftUI

struct Meal: View {
    @ObservedObject var viewModel: MealViewModel
    var body: some View {
        ZStack {
            if case let .loaded(loadedState) = viewModel.state {
                loadedView(state: loadedState)
            } else {
                loadingView()
            }
        }.onAppear {
            viewModel.send(.viewAppeared)
        }
    }
    
    func loadingView() -> some View {
        ProgressView()
    }
    
    
    func loadedView(state: MealViewModel.LoadedState) -> some View {
        
        List {
            if let listMeals = state.meals.meals {
                
                ForEach(listMeals) { meals in
                    
                    if let strMeal = meals.strMealThumb {
                        AsyncImage(
                            url: URL(
                                string: strMeal
                            )) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 240)
                                    .listRowSeparator(.hidden)
                            } placeholder: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.gray.opacity(0.6))
                                        .frame(height: 240)
                                    ProgressView()
                                }
                            }
                            .aspectRatio(3 / 2, contentMode: .fill)
                            .cornerRadius(12)
                            .padding(.vertical)
                            .shadow(radius: 4)
                            .listRowSeparator(.hidden)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        if let strMeal = meals.strMeal {
                            Text(strMeal)
                                .listRowSeparator(.hidden)
                                .font(.system(size: 20))
                                .bold()
                        }
                        
                        if let strCategory = meals.strCategory {
                            Text(strCategory)
                                .listRowSeparator(.hidden)
                                .font(.system(size: 18))
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Instrucciones")
                            .listRowSeparator(.hidden)
                            .font(.system(size: 18))
                            .bold()
                        
                        if let strInstructions = meals.strInstructions {
                            Text(strInstructions)
                                .listRowSeparator(.hidden)
                                .font(.system(size: 15))
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ingredientes")
                            .listRowSeparator(.hidden)
                            .font(.system(size: 18))
                            .bold()
                        
                        if let strIngredient1 = meals.strIngredient1 {
                            Text(strIngredient1)
                                .listRowSeparator(.hidden)
                                .font(.system(size: 18))
                        }
                        
                        if let strIngredient2 = meals.strIngredient2 {
                            Text(strIngredient2)
                                .listRowSeparator(.hidden)
                                .font(.system(size: 18))
                        }
                        
                        if let strIngredient3 = meals.strIngredient3 {
                            Text(strIngredient3)
                                .listRowSeparator(.hidden)
                                .font(.system(size: 18))
                        }
                        
                        if let strIngredient4 = meals.strIngredient4 {
                            Text(strIngredient4)
                                .listRowSeparator(.hidden)
                                .font(.system(size: 18))
                        }
                    }
                }
            }
        }
    }
}

