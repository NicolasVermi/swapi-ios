//
//  SWApiNetwork.swift
//  StarWars
//
//  Created by Nicolas on 16/10/2020.
//

import Foundation

final class SWApiNetwork: SWAPI {
    
    init() {
        
    }
    
//    func loadFilms(completionHanlder: @escaping (Result<Data, Error>) -> Void) {
//        let session = URLSession.shared
//        let url = URL(string: "https://swapi.dev/api/films")!
//        let task = session.dataTask(with: url, completionHandler: { data, response, error in
//            print(data)
//            print(response)
//            print(error)
//
//            if let error = error {
//                completionHanlder(.failure(error))
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completionHanlder(.failure(URLError(.badServerResponse)))
//                return
//            }
//
//            guard (200...299).contains(httpResponse.statusCode), let data = data else {
//                completionHanlder(.failure(URLError(.badServerResponse)))
//                return
//            }
//            DispatchQueue.main.async {
//                completionHanlder(.success(data))
//            }
//        })
//
//        task.resume()
//    }
//
//
//    func loadPeople(completionHanlder: @escaping (Result<Data, Error>) -> Void) {
//        let session = URLSession.shared
//        let url = URL(string: "https://swapi.dev/api/people")!
//        let task = session.dataTask(with: url, completionHandler: { data, response, error in
//
//            print(data)
//            print(response)
//            print(error)
//
//            if let error = error {
//                completionHanlder(.failure(error))
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse else{
//                completionHanlder(.failure(URLError(.badServerResponse)))
//                return
//            }
//
//            guard (200...299).contains(httpResponse.statusCode), let data = data else {
//                completionHanlder(.failure(URLError(.badServerResponse)))
//                return
//            }
//
//            DispatchQueue.main.async {
//                completionHanlder(.success(data))
//            }
//        })
//        task.resume()
//    }
//
//
//    func loadPlanet(stringa: String, completionHanlder: @escaping (Result<Data, Error>) -> Void) {
//        let session = URLSession.shared
//        let url = URL(string: stringa)!
//        let task = session.dataTask(with: url, completionHandler: { data, response, error in
//
//            print(data)
//            print(response)
//            print(error)
//
//            if let error = error {
//                completionHanlder(.failure(error))
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse else{
//                completionHanlder(.failure(URLError(.badServerResponse)))
//                return
//            }
//
//            guard (200...299).contains(httpResponse.statusCode), let data = data else {
//                completionHanlder(.failure(URLError(.badServerResponse)))
//                return
//            }
//
//            DispatchQueue.main.async {
//                completionHanlder(.success(data))
//            }
//        })
//        task.resume()
//    }
    
    func load(stringa: String, completionHanlder: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
        let url = URL(string: stringa)!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            print(data)
            print(response)
            print(error)
            
            if let error = error {
                completionHanlder(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else{
                completionHanlder(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode), let data = data else {
                completionHanlder(.failure(URLError(.badServerResponse)))
                return
            }
            
            DispatchQueue.main.async {
                completionHanlder(.success(data))
            }
        })
        task.resume()
    }
    
    
    
}


protocol SWAPI {
//    func loadFilms(completionHanlder: @escaping (Result<Data, Error>) -> Void)
//    func loadPeople(completionHanlder: @escaping (Result<Data, Error>) -> Void)
//    func loadPlanet(stringa: String, completionHanlder: @escaping (Result<Data, Error>) -> Void)
    func load(stringa: String, completionHanlder: @escaping (Result<Data, Error>) -> Void)
}
