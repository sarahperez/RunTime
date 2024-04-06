//
//  SunData.swift
//  RunTime
//
//  Created by Tori Pineda on 4/6/24.
//

import Foundation

class SunViewModel: ObservableObject {
    @Published var sunData: SunData?
    @Published var error: Error?
    
    func getSunData() async throws -> SunData {
        let endpoint = "https://api.sunrisesunset.io/json?lat=29.6520&lng=-82.3250"
        
        guard let url = URL(string: endpoint) else {throw SunDataError.invalidURL}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw SunDataError.invalidResponse
            }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(SunDataResponse.self, from: data)
            return decodedData.results
        } catch {
            throw SunDataError.invalidData
        }
    }
    
    func fetch() {
        Task {
            do {
                self.sunData = try await getSunData()
            } catch {
                self.error = error
                print(error)
            }
        }
    }
}

struct SunData: Codable {
    let sunrise: String
    let sunset: String
}

struct SunDataResponse: Codable {
    let results: SunData
    let status: String
}

enum SunDataError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
