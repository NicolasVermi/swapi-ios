//
//  FilmViewViewModel.swift
//  StarWars
//
//  Created by Nicolas on 13/10/2020.
//


import Combine
import Foundation

final class FilmViewViewModel: ObservableObject {
    private let api: SWAPI
    @Published var films = [Film]()
    @Published var isLoading = false
    
    init(api: SWAPI = SWApiNetwork()) {
        self.api = api
    }
    
    func handleServerError(_ response:URLResponse?)  {
        isLoading=false
        films=[]
    }
    
    func handleSuccess(data: Data){
        self.isLoading = false
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(SWAPIResponse<[Film]>.self, from: data)
            self.films = response.results
        } catch {
            self.handleServerError(nil)
        }
    }
    
    func loadFilms() {
        guard !isLoading else { return }
        self.isLoading = true
//        api.loadFilms { [weak self] result in

        api.load(stringa: "https://swapi.dev/api/films") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.handleSuccess(data: data)
            case .failure:
                self.handleServerError(nil)
            }
        }
    }
}
