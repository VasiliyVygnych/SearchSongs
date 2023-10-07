//
//  MusicDetailPresenter.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import UIKit


class MusicDetailPresenter: MusicDetailPresenterProtocol {
    
    weak var view: MusicDetailViewProtocol?
    var router: MusicDetailRouterProtocol?
    var interactor: MusicDetailInteractorInputProtocol?
    
    func viewDidLoad() {
        if let songItem = interactor?.songItem {
            view?.showSong(song: songItem)
        }
    }
    
}

extension MusicDetailPresenter: MusicDetailInteractorOutputProtocol {
    

}
