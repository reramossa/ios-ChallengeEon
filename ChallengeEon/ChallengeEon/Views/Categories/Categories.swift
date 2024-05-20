//
//  Categories.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 17/05/24.
//

import SwiftUI

struct Categories: View {
    @ObservedObject var viewModel: CategoriesViewModel
    @State private var isSideBarOpened = false
    
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
    
    func loadedView(state: CategoriesViewModel.LoadedState) -> some View {
        
        List {
            if let listCategories = state.categories.categories {
                ForEach(listCategories) { categorie in
                    if let strCategory = categorie.strCategory {
                        NavigationLink(destination: CategoriesDetail(viewModel: CategoriesDetailViewModel(strCategory: strCategory)) .navigationBarTitle(strCategory)) {
                            HStack {
                                if let strMeal = categorie.strCategoryThumb {
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
                                    Text(strCategory)
                                        .listRowSeparator(.hidden)
                                        .font(.system(size: 20))
                                        .bold()
                                        .frame(alignment: .center)
                                    if let strCategoryDescription = categorie.strCategoryDescription,  strCategoryDescription.count > 9{
                                        Text(String(strCategoryDescription.prefix(10)))
                                            .listRowSeparator(.hidden)
                                            .font(.system(size: 17))
                                            .truncationMode(.middle)
                                            .frame(alignment: .center)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.inset)
        .navigationTitle("Categorias")
        .navigationBarTitleDisplayMode(.inline)
    }
}



