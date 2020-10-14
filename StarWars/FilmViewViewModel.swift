//
//  FilmViewViewModel.swift
//  StarWars
//
//  Created by Nicolas on 13/10/2020.
//

import Combine
import Foundation

final class FilmViewViewModel: ObservableObject {
    @Published var films = [String]()
    @Published var isLoading = false
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
            self.films = response.results.map { $0.title }
        } catch {
            self.handleServerError(nil)
        }
    }
    
    func loadFilms() {
        guard !isLoading else { return }
        
        // caricare la lista di films...
        self.isLoading = true
        let session = URLSession.shared
        let url = URL(string: "https://swapi.dev/api/films")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            print(data)
            print(response)
            print(error)
            if error != nil {
                // OH NO! An error occurred...
                print("An error occurred")
                self.handleServerError(response) //mi da errore
                return
            }else{
                print("tutto bene")
            }
            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode),
                let data = data
            else {
                self.handleServerError(response)
                return
            }
            DispatchQueue.main.async {
                self.handleSuccess(data: data)
            }
            
        })
        task.resume()
        
        
        
        
       

        
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLoading = false
            self.films = [
                "film2",
                "film3",
                "film4",
                "film5",
                "film6",
            ]
        }*/
        
    }
    //
}
