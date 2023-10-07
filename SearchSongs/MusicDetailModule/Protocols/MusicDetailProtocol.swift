//
//  MusicDetailProtocol.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import UIKit

//MARK: - ViewProtocol
protocol MusicDetailViewProtocol: AnyObject {
    var presenter: MusicDetailPresenterProtocol? { get set }
    
    func showSong(song: Results) 
}

//MARK: - PresenterProtocol
protocol MusicDetailPresenterProtocol: AnyObject {
    var view: MusicDetailViewProtocol? { get set }
    var interactor: MusicDetailInteractorInputProtocol? { get set }
    var router: MusicDetailRouterProtocol? { get set }
    
    func viewDidLoad() 
}

//MARK: - InteractorInputProtocol
protocol MusicDetailInteractorInputProtocol: AnyObject {
    var presenter: MusicDetailInteractorOutputProtocol? { get set }
    var network: MusicListNetworkProtocol? { get set }
    var songItem: Results? { get set }
    
}

//MARK: - InteractorOutputProtocol
protocol MusicDetailInteractorOutputProtocol: AnyObject {
    
}

//MARK: - RouterProtocol
protocol MusicDetailRouterProtocol: AnyObject {
    static func createTodoDetailRouterModule(with song: Results) -> UIViewController
    func navigateBackToListViewController(from view: MusicDetailViewProtocol)
}

