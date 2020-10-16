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
    let films: [Film]
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
                    .padding(.top, 100)
                Text("FILM LIST")
                    .foregroundColor(.yellow)
                    .bold()
                    .font(.system(size: 25))
                    .navigationBarTitle("Film List", displayMode: .inline)
                    .padding(.bottom, 110)
                Spacer()
                
                if !isLoading {
                    ForEach(films) { film in
                        NavigationLink(destination: PeopleConteinerView(filmId: "\(film.episodeId)")) {
                            Text(film.title).foregroundColor(.white).font(.system(size: 30))
                                .bold()
                                .padding(.vertical, 15)
                        }
                        
                    }
                    Text("").padding(.bottom,200)
                }
                else{
                    VStack {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                            .foregroundColor(.yellow)
                    }.padding(.bottom,100)
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
                FilmView(
                    films: [
                        Film(title: "1", episodeId: 1),
                        Film(title: "2", episodeId: 2),
                        Film(title: "3", episodeId: 3),
                    ],
                    isLoading: false
                )
                
            }
            
            NavigationView {
                FilmView(films: [], isLoading: true)
            }
        }
    }
}
