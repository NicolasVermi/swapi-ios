
//
//  FilmViewViewModel.swift
//  StarWars
//
//  Created by Nicolas on 13/10/2020.
//

import Combine
import Foundation

final class PeopleViewViewModel: ObservableObject {
    let filmId: String
    @Published var people = [People]()
    @Published var isLoading = false
    
    init(filmId: String) {
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
        let session = URLSession.shared
        let url = URL(string: "https://swapi.dev/api/people")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            print(data)
            print(response)
            print(error)
            
            if error != nil {
                print("An error occurred")
                self.handleServerError(response)
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
        
        
        
        
       


        
    }
    //
}
