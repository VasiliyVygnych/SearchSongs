//
//  Netwokr.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import UIKit

class MusicListNetwork: MusicListNetworkProtocol {
    
    func request(searchText: String,
                 completion: @escaping (SongData?) -> Void) {
        var components = URLComponents(string: "https://itunes.apple.com/search?term=")
        components?.queryItems = [URLQueryItem(name: "term",
                                               value: searchText)]
        guard let url = components?.url else { return }
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { [weak self ]
                (data, response, error) in
                guard let _ = self,
                      let data = data else { return }
                guard let song = try?
                        JSONDecoder().decode(SongData.self,
                                             from: data) else { return }
                let model = song
                completion(model)
            }
        task.resume()
    }
// MARK: - searchResults
    func searchSong(searchText: String,
                    completion: @escaping (SongData?) -> Void) {
        self.request(searchText: searchText) { (sougData) in
                guard let sougData else { return }
                completion(sougData)
        }
    }
}
