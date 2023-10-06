//
//  MusicListInteractor.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import Foundation

class MusicListInteractor: MusicListInteractorInputProtocol {
    
    weak var presenter: MusicListInteractorOutputProtocol?
    var network: MusicListNetworkProtocol?
    var song: SongData?
    
    func setSearchText(text: String) {
        network?.searchSong(searchText: text,
                            completion: { [ weak self ] searSoung in
            DispatchQueue.main.async {
                guard let model = searSoung else { return }
                self?.song = model
                self?.presenter?.didRetrieveSongs(songs: self?.song)
            }
        })
    }
}
