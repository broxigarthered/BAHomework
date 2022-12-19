//
//  DefaultUserDetailsRepository.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 18.12.22.
//

import Foundation

final class DefaultUserDetailsRepository: UserDetailsRepository {
    
    private let networker: DataTransferService
    
    init(networker: DataTransferService) {
        self.networker = networker
    }
    
    func getUserDetails(id: Int, decoder: JSONDecoder, completion: @escaping (Result<UserDetailsDTO, NetworkError>) -> Void) {
        
        let endpoint = APIEndpoints.getUserDetails(for: id)
        
        networker.request(endpoint: endpoint) { dataResponse, error, response in
            if let data = dataResponse,
               let response = response {
                if response.statusCode == 200 {
                    let wrapper: RequestWrapper = RequestWrapper(apiResponseClass: UserDetailsDTO.self)
                    if let userDetails = self.parseData(data: data, rawResponse: response, wrapper: wrapper) as? UserDetailsDTO {
                        completion(.success(userDetails))
                    } else {
                        let networkError = NetworkError.invalidData
                        completion(.failure(networkError))
                    }
                    
                } else {
                    if let error = error {
                        completion(.failure(error))
                    }
                    
                }
            }
        }
    }
    
    private func parseData(data: Data?, rawResponse: HTTPURLResponse?, wrapper: RequestWrapper) -> DeserializableModel? {
        var apiResponse: DeserializableModel?
        
        var params: [String: AnyObject]?
        if let data = data {
            do {
                params = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
                params?["httpStatusCode"] = rawResponse?.statusCode as AnyObject
                
                apiResponse = wrapper.apiResponseClass.fromJSON(params)
                return apiResponse
                
            } catch {
                print("JSON parse error with error message:", "\(error)")
                if let responseText = String(data: data, encoding: .utf8) {
                    let responseBool = NSString(string: responseText).boolValue
                    
                    params = [:]
                    params?["status"] = responseText as AnyObject
                    params?["valid"] = responseBool as AnyObject
                }
            }
        }
        
        return nil
    }
}

