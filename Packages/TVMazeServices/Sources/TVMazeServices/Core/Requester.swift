import Foundation
import TVMazeServicesInterface
 
protocol RequesterProtocol {
    func make<Model: Decodable>(
        request: RequestProtocol,
        completion: @escaping (Result<Model, RequesterError>) -> Void
    )
    
    func make<Model: Decodable>(
        paginatedRequest: RequestProtocol,
        with pagination: Pagination<Model>,
        completion: @escaping (Result<Pagination<Model>, RequesterError>) -> Void
    )
}

final class Requester: RequesterProtocol {
    func make<Model: Decodable>(
        request: RequestProtocol,
        completion: @escaping (Result<Model, RequesterError>) -> Void
    ) {
        guard let url = URL(string: request.urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
                
        debugPrint("📶 REQUEST LOG \(urlRequest.httpMethod ?? "") \(urlRequest.url?.absoluteString ?? .init())")

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error {
                debugPrint("❌ Error Response: \(error.localizedDescription)")
                completion( .failure(.requestFailed(error: error)))
                return
            }
            
            guard let data else {
                completion(.failure(.emptyData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let model: Model
            do {
                model = try decoder.decode(Model.self, from: data)
                completion(.success(model))
                return
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                debugPrint("Key '\(key)' not found:", context.debugDescription)
                debugPrint("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                debugPrint("Value '\(value)' not found:", context.debugDescription)
                debugPrint("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                debugPrint("Type '\(type)' mismatch:", context.debugDescription)
                debugPrint("codingPath:", context.codingPath)
            } catch {
                debugPrint("error: ", error)
            }
        
            completion(.failure(.decodeError))
        }.resume()
    }
    
    func make<Model: Decodable>(
        paginatedRequest: RequestProtocol,
        with pagination: Pagination<Model>,
        completion: @escaping (Result<Pagination<Model>, RequesterError>) -> Void
    ) {
        make(request: paginatedRequest) { (result: Result<[Model], RequesterError>) in
            switch result {
            case .success(let newPage):
                completion(
                    .success(.init(
                        page: pagination.page + 1,
                        content: pagination.content + newPage
                    ))
                )
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
