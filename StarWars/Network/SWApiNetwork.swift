import Foundation

final class SWApiNetwork: SWAPI {
    private let decoder: JSONDecoder
    
    
    init() {
        self.decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    
    
    func parse<Response: Codable>(_ data: Data) -> Result<Response, Error> {
        do {
            let response = try decoder.decode(Response.self, from: data)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    
    
    func load<Response: Codable>(stringa url: URL, completionHanlder: @escaping (Result<Response, Error>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard let self = self else { return }
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
            
            let result: Result<Response, Error> = self.parse(data)
            DispatchQueue.main.async {
                completionHanlder(result)
            }
        })
        task.resume()
    }
}


protocol SWAPI {
    
    func load<Response: Codable>(stringa url: URL, completionHanlder: @escaping (Result<Response, Error>) -> Void)
}
