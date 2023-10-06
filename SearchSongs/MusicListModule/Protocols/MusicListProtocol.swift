//
//  MusicListProtocol.swift
//  SearchSongs
//
//  Created Vasiliy Vygnych on 04.10.2023.
//

import UIKit

//MARK: - ViewProtocol
protocol MusicListViewProtocol: AnyObject {
    var presenter: MusicListPresenterProtocol? { get set }
    func showSongs(songs: SongData?)
}

//MARK: - PresenterProtocol
protocol MusicListPresenterProtocol: AnyObject {
    var view: MusicListViewProtocol? { get set }
    var interactor: MusicListInteractorInputProtocol? { get set }
    var router: MusicListRouterProtocol? { get set }

    func didSelectRowAt(song: Results)
    func getSearchText(text: String)
}

//MARK: - InteractorInputProtocol
protocol MusicListInteractorInputProtocol: AnyObject {
    var presenter: MusicListInteractorOutputProtocol? { get set }
    var network: MusicListNetworkProtocol? { get set }
    var song: SongData? { get set }
    
    func setSearchText(text: String)
}

//MARK: - InteractorOutputProtocol
protocol MusicListInteractorOutputProtocol: AnyObject {
    func didRetrieveSongs(songs: SongData?)
}

//MARK: - RouterProtocol
protocol MusicListRouterProtocol: AnyObject {
    static func createTodoListModule() -> UIViewController
    func presentToDoDetailScreen(from view: MusicListViewProtocol,
                                 for song: Results)
}
//MARK: - RouterProtocol
protocol MusicListNetworkProtocol: AnyObject {
    func searchSong(searchText: String,
                    completion: @escaping (SongData?) -> Void)
    
}
