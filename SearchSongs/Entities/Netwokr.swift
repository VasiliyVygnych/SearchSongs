//
//  Netwokr.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import UIKit
//import AVFoundation

class MusicListNetwork: MusicListNetworkProtocol {
    
// MARK: - request
    func request(urlString: String, completion: @escaping (Result <Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in // response
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
// MARK: - fetchData
    func fetchData(urlString: String, completion: @escaping (SongData?) -> Void) {
        self.request(urlString: urlString) { (result)  in
            switch result {
            case .success(let data):
                do {
                    let song = try JSONDecoder().decode(SongData.self, from: data)
                    completion(song)
//                    print("MODEL: \(song)")
                } catch let jsonError {
                    print("ERROR", jsonError)
                    completion(nil)
                }
            case .failure(let error):
                print("ERROR DATA \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
// MARK: - searchResults
    func searchSong(searchText: String,
                    completion: @escaping (SongData?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText)"
            self.fetchData(urlString: urlString) { (sougData) in
                guard let sougData else { return }
                completion(sougData)
        }
    }
}
