//
//  MusicListPresenter.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import UIKit

class MusicListPresenter: MusicListPresenterProtocol {

    weak var view: MusicListViewProtocol?
    var interactor: MusicListInteractorInputProtocol?
    var router: MusicListRouterProtocol?

    func getSearchText(text: String) {
        interactor?.setSearchText(text: text)
    }
    func didSelectRowAt(song: Results) {
        guard let view = view else { return }
        router?.presentToDoDetailScreen(from: view,
                                        for: song)
    }
}

extension MusicListPresenter: MusicListInteractorOutputProtocol {
    func didRetrieveSongs(songs: SongData?) {
        view?.showSongs(songs: songs)
    }
}
