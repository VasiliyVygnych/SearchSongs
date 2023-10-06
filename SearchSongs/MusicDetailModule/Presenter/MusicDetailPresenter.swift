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

    
    func didSelecPauseButton() {
        print("Pause")
    }
    func didSelecPlayButton() {
        print("play")
    }
    func didSelecNextButton(sender: UIButton) {
        print("next track")
    }
    func didSelecPreviousButton(sender: UIButton) {
        print("previous track")
    }
    func didSelecPlaybackProgress(sender: UISlider) {
        print("playback progress")
    }
    func didSelecoVolume(sender: UISlider) {
        print("volume")
    }
}

extension MusicDetailPresenter: MusicDetailInteractorOutputProtocol {
  
}
