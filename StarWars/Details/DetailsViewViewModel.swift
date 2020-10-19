
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
        guard let peopleURL=URL(string: "https://swapi.dev/api/people")else
        {
            handleServerError(nil)
            return
        }
        api.load(stringa: peopleURL) { [weak self] (result: Result<SWAPIResponse<[Details]>, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.handleSuccess(response: response)
            case .failure:
                self.handleServerError(nil)
            }
        }
    }
    
    func loadPlanet(stringa: String) {
        guard !isLoading else { return }
        self.isLoading = true
        guard let planetURL=URL(string: stringa)else
        {
            handleServerError(nil)
            return
        }
        api.load(stringa: planetURL ) { [weak self] (result: Result<Planet, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let planet):
                self.handleSuccess(response: planet)
            case .failure:
                self.handleServerError(nil)
            }
        }
    }
 
    
    func handleSuccess(response: SWAPIResponse<[Details]>){
        self.isLoading = false
        self.details = response.results
            .filter { person in return person.name == personId }
            .first

        loadPlanet(stringa: self.details!.homeworld)
    }
    
    
    func handleSuccess(response: Planet){
        self.isLoading = false
        self.planet = response
    }
}
