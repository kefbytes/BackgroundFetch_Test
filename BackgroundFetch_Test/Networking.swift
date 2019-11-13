//
//  Networking.swift
//  BackgroundFetch_Test
//
//  Created by Franks,Kent on 11/13/19.
//  Copyright © 2019 Kefbytes LLC. All rights reserved.
//

import Foundation

enum FetchResponse {
    case new
    case old
    case fail
}

struct Networking {
    static func fetchData(numberOfPerson: Int, completion: @escaping (FetchResponse) -> Void) {
        let urlString = "https://swapi.co/api/people/\(numberOfPerson)/"
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let jsonData = data else {
                return
            }
            do {
                print("🤖🔸🔸🔸🤖 fetch performed.")
                let response = try JSONDecoder().decode(StarWarsCharactersFetchResponse.self, from: jsonData)
                guard let _ = response.results else {
                    completion(.fail)
                    return
                }
                completion(.new)
            } catch {
                completion(.fail)
            }
            } .resume()
    }
}
