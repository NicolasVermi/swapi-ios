
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
    
    func handleSuccess(response: SWAPIResponse<[People]>){
        self.isLoading = false
        self.people = response.results.filter { person in
            let filmCount = person
                .films
                .filter { filmTitle in filmTitle.contains(filmId) }
                .count
            return filmCount > 0
        }
    }
    
    func loadPeople() {
        guard !isLoading else { return }
        self.isLoading = true        
        api.load(stringa: "https://swapi.dev/api/people" ) { [weak self] (result: Result<SWAPIResponse<[People]>, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.handleSuccess(response: response)
            case .failure:
                self.handleServerError(nil)
            }
            
        }
    }
    
    
    //
}
