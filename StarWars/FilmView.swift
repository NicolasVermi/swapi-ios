//
//  FilmView.swift
//  StarWars
//
//  Created by Nicolas on 13/10/2020.
//

import SwiftUI
struct FilmConteinerView: View {
    @StateObject var viewModel = FilmViewViewModel()

    var body: some View{
        FilmView(films: viewModel.films, isLoading: viewModel.isLoading)
            .onAppear { viewModel.loadFilms() }
        
    }
}

struct FilmView: View {
    let films: [String]
    let isLoading: Bool
    var body: some View {
        ZStack {
            Image("sky")
                .edgesIgnoringSafeArea(.all)
            VStack{
                //Spacer()
                
                Text("STAR WARS")
                    .foregroundColor(.yellow)
                    .bold()
                    .font(.system(size: 50))
                Text("FILM LIST")
                    .foregroundColor(.yellow)
                    .bold()
                    .font(.system(size: 25))
                    .navigationBarTitle("Film List")
                    .padding(.bottom, 130)
                //Spacer()
                
                if !isLoading {
                    ForEach(films, id: \.self) { film in
                        NavigationLink(destination: PeopleConteinerView()) {
                            Text(film).foregroundColor(.white).font(.system(size: 30))
                                .bold()
                                .padding(.vertical, 15)
                        }
                    }
                }
                else{
                    VStack {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                            .foregroundColor(.yellow)
                    }
                }
                
                Spacer()
                
            }
        }
    }
    
}

struct FilmView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                FilmView(films: ["1","1","1"], isLoading: false)
            }
            
            NavigationView {
                FilmView(films: [], isLoading: true)
            }
        }
    }
}
