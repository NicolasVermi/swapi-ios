
import Combine
import Foundation

final class DetailsViewViewModel: ObservableObject {
    let personId: String 
    @Published var details: Details?
    @Published var planet: Planet?
    @Published var isLoading = false
    
    init(personId: String) {
        self.personId = personId
    }
    
    func handleServerError(_ response:URLResponse?)  {
        isLoading=false
        details = nil
        planet = nil
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
            
//            let url = self.details?.homeworld
//            loadPlanet(url)
            
            loadPlanet(stringa: self.details!.homeworld)
            
            
        } catch {
            self.handleServerError(nil)
        }
    }
    
    
    func loadDetails() {
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
        self.isLoading=false
    }

    func loadPlanet(stringa: String) {
        guard !isLoading else { return }
        
        self.isLoading = true
        let session = URLSession.shared
        let url = URL(string: stringa)!
        let task2 = session.dataTask(with: url, completionHandler: { data, response, error in
            
            print(data)
            print("response: \(response)")
            print("error: \(error)")
            
            if error != nil {
                print("An error occurred")
                self.handleServerError(response)
                return
            }else{
                print("tutto bene planet")
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
                self.handleSuccess2(data: data)
            }
            
        })
        task2.resume()
    }
    
    
    func handleSuccess2(data: Data){
        self.isLoading = false
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(Planet.self, from: data)
            self.planet = response
            print("dentro il do")
        } catch {
            print("dentro il catch: \(error)")
            self.handleServerError(nil)
        }
    }
}
