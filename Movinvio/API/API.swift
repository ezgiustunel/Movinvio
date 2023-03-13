//
//  API.swift
//  Movinvio
//
//  Created by Ezgi Üstünel on 4.06.2022.
//

import Foundation
import Alamofire

struct API {
    
    static func getMovies(completion:@escaping (Result<Movie, Error>) -> Void) {
        performRequest(route: APIRouter.movies(id: Constants.movieID, apiKey: Constants.apiKey)) { (result:(Result<Movie?, Error>)) in
            switch result {
            case Result.success(let response):
                if let movieResponse = response {
                    completion(.success(movieResponse))
                } else {
                    completion(.success(Movie()))
                }
                break
            case Result.failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
    private static func performRequest<T>(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, Error>) -> Void) where T: Codable {
        
        AF.request(route).response { response in
            print(route)
            if let error = response.error {
                completion(Result.failure(error))
                return
            }
            
            switch response.result {
            case let .success(data):
                
                guard let data = data else {
                    completion(Result.failure(CustomError.noResponseData.error))
                    return
                }
                
                guard let responseModel = try? decoder.decode(T.self, from: data) else {
                    completion(Result.failure(CustomError.invalidData.error))
                    return
                }
                
                completion(Result.success(responseModel ))
                
            case let .failure(error):
                completion(Result.failure(error))
            }
        }
    }
}
