//
//  CategoriesDetail.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 18/05/24.
//

import SwiftUI

struct CategoriesDetail: View {
    @ObservedObject var viewModel: CategoriesDetailViewModel
    
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
    
    func loadedView(state: CategoriesDetailViewModel.LoadedState) -> some View {
        
        List {
            if let listCategoriesDetail = state.categoriesDetail.meals {
                ForEach(listCategoriesDetail) { meals in
                    if let idMeal = meals.idMeal {
                        NavigationLink(destination: Meal(viewModel: MealViewModel(idMeal: idMeal)) .navigationBarTitle(meals.strMeal ?? "")) {
                            HStack {
                                if let strMeal = meals.strMealThumb {
                                    AsyncImage(
                                        url: URL(
                                            string: strMeal
                                        )) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width:100, height: 100)
                                                .listRowSeparator(.hidden)
                                        } placeholder: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(.gray.opacity(0.6))
                                                    .frame(width:100, height: 100)
                                                ProgressView()
                                            }
                                        }
                                        .aspectRatio(3 / 2, contentMode: .fill)
                                        .cornerRadius(12)
                                        .padding(.vertical)
                                        .shadow(radius: 4)
                                        .listRowSeparator(.hidden)
                                }
                                
                                Spacer().frame(width: 50)
                                
                                VStack {
                                    if let strMeal = meals.strMeal {
                                        Text(strMeal)
                                            .listRowSeparator(.hidden)
                                            .font(.system(size: 20))
                                            .bold()
                                            .frame(alignment: .center)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
