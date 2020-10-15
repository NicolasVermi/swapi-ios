
import Combine
import Foundation

final class DetailsViewViewModel: ObservableObject {
    let personId: String 
    @Published var details: Details?
    @Published var isLoading = false
    
    init(personId: String) {
        self.personId = personId
    }
    
    func handleServerError(_ response:URLResponse?)  {
        isLoading=false
        details = nil
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
        
        
        
        
       


        
    }
    //
}
