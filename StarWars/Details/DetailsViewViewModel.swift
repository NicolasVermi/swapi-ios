
import Combine
import Foundation

final class DetailsViewViewModel: ObservableObject {
    let personId: String
    private let api: SWAPI
    @Published var details: Details?
    @Published var planet: Planet?
    @Published var isLoading = false
    
    init(personId: String, api: SWAPI = SWApiNetwork()) {
        self.personId = personId
        self.api = api
    }
    
    func handleServerError(_ response:URLResponse?)  {
        isLoading=false
        details = nil
        planet = nil
    }


    func loadDetails() {
        guard !isLoading else { return }
        self.isLoading = true
//        api.loadPeople { [weak self] result in
        api.load(stringa: "https://swapi.dev/api/people") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.handleSuccess(data: data)
            case .failure:
                self.handleServerError(nil)
            }
        }
    }
    
    
    func loadPlanet(stringa: String) {
        guard !isLoading else { return }
        self.isLoading = true
//        api.loadPlanet(stringa: stringa) { [weak self] result in
          api.load(stringa: stringa) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.handleSuccess2(data: data)
            case .failure:
                self.handleServerError(nil)
            }
        }
    }
 
    
    func handleSuccess(data: Data){
        self.isLoading = false
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(SWAPIResponse<[Details]>.self, from: data)
            self.details = response.results
                .filter { person in return person.name == personId }
                .first

            loadPlanet(stringa: self.details!.homeworld)
            
            
        } catch {
            self.handleServerError(nil)
        }
    }
    
    func handleSuccess2(data: Data){
        self.isLoading = false
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(Planet.self, from: data)
            self.planet = response
        } catch {
            self.handleServerError(nil)
        }
    }
}
