
//
//  FilmViewViewModel.swift
//  StarWars
//
//  Created by Nicolas on 13/10/2020.
//

import Combine
import Foundation

final class PeopleViewViewModel: ObservableObject {
    private let api: SWAPI
    let filmId: String
    @Published var people = [People]()
    @Published var isLoading = false

    init(filmId: String,api: SWAPI = SWApiNetwork()) {
        self.api = api
        self.filmId = filmId
    }
    
    func handleServerError(_ response:URLResponse?)  {
        isLoading=false
        people=[]
    }
    
    func handleSuccess(data: Data){
        self.isLoading = false

        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(SWAPIResponse<[People]>.self, from: data)
            self.people = response.results.filter { person in
                let filmCount = person
                    .films
                    .filter { filmTitle in filmTitle.contains(filmId) }
                    .count
                return filmCount > 0
            }
            
        } catch {
            self.handleServerError(nil)
        }
    }
    
    func loadPeople() {
        guard !isLoading else { return }
        self.isLoading = true
//        api.loadPeople { [weak self] result in
        
        api.load(stringa: "https://swapi.dev/api/people" ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.handleSuccess(data: data)
            case .failure:
                self.handleServerError(nil)
            }
            
        }
    }
    
    
    //
}
