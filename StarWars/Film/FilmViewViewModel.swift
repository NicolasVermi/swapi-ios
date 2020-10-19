
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
    
    func handleSuccess(response: SWAPIResponse<[Film]>){
        self.isLoading = false
        self.films = response.results
    }
    
    func loadFilms() {
        guard !isLoading else { return }
        self.isLoading = true
        guard let filmsURL = URL(string: "https://swapi.dev/api/films") else {
            handleServerError(nil)
            return
        }
        api.load(stringa: filmsURL) { [weak self] (result: Result<SWAPIResponse<[Film]>, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.handleSuccess(response: response)
            case .failure:
                self.handleServerError(nil)
            }
        }
    }
}
