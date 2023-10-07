//
//  MusicDetailInteractor.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import Foundation

class MusicDetailInteractor: MusicDetailInteractorInputProtocol {
    
    weak var presenter: MusicDetailInteractorOutputProtocol?
    var network: MusicListNetworkProtocol?
    
    var songItem: Results?
    
    
    
}
