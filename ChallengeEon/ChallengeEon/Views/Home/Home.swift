//
//  Home.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 17/05/24.
//

import SwiftUI

struct Home: View {
    @State private var isSideBarOpened = false
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                if case let .loaded(loadedState) = viewModel.state {
                    loadedView(state: loadedState)
                } else {
                    loadingView()
                }
            }.onAppear {
                viewModel.send(.viewAppeared)
            }
        }
    }
    
    func loadingView() -> some View {
        ProgressView()
    }
    
    func loadedView(state: HomeViewModel.LoadedState) -> some View {
        
        List {
            if let listMeals = state.meals.meals {
                ForEach(listMeals) { meals in
                    if let strMeal = meals.strMeal {
                        
                        HStack {
                            Spacer()
                                .frame(width: 50)
                            Text(strMeal).onTapGesture {
                                viewModel.send(.mealTapped(meals))
                            }
                            .listRowSeparator(.hidden)
                            .font(.system(size: 20))
                            .bold()
                        }
                        
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
                    }
                }
            }
            
        }
        .listStyle(.inset)
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}
