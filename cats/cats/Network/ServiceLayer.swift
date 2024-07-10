//
//  ServiceLayer.swift
//  cats
//
//  Created by Alan Rodriguez on 02/07/24.
//

import Foundation

class ServiceLayer {
    static let shared = ServiceLayer()
    private lazy var tasks = Set([URLSessionDataTask]())
    
    private func addTask(_ task: URLSessionDataTask) {
        tasks.insert(task)
    }
    
    private func removeTask(forRequest request: URLRequest) {
        guard let task = tasks.filter({$0.currentRequest == request}).first else { return }
        tasks.remove(task)
    }
    
    // MARK: - Request
    func getRequest<T: Decodable>(url: String) async -> Result<T?, ServiceError> {
        guard let url = URL(string: url) else {
            return .failure(.genericError)
        }
        
        let request = URLRequest(url: url)
        
        return await withCheckedContinuation { (continuation: CheckedContinuation<Result<T?, ServiceError>, Never>) in
            execute(request) { result in
                continuation.resume(returning: result)
            }
        }
    }
    
    // MARK: - Request trigger
    private func execute<T: Decodable>(_ request: URLRequest,
                                       completion: @escaping (Result<T?, ServiceError>) -> Void) {
        print("::: REQUEST URL: \(request.url?.absoluteString ?? "NOT DEFINED") :::")
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = request.timeoutInterval
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            ServiceLayer.shared.removeTask(forRequest: request)
            if let error = error {
                print("::: ERROR ON REQUEST:" + error.localizedDescription + " :::")
                completion(.failure(.genericError))
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299:
                    if data.isEmpty {
                        return completion(.success(nil))
                    }
                    do {
                        let response = try JSONDecoder().decode(T.self, from: data)
                        return completion(.success(response))
                    } catch {
                        return completion(.failure(ServiceError.genericError))
                    }
                default:
                    print("::: ERROR ON REQUEST: UKNOWN ERROR :::")
                    return completion(.failure(ServiceError.genericError))
                }
            }
        }
        
        ServiceLayer.shared.addTask(task)
        
        task.resume()
    }
}

// MARK: - Errors
enum ServiceError: Error {
    case genericError
    case mockupMissingError
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .genericError:
            return NSLocalizedString("There was an error on the response", comment: "Generic Error")
        case .mockupMissingError:
            return NSLocalizedString("There is no JSON file for that request", comment: "JSON FILE MISSING")
        }
    }
}
