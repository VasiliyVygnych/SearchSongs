//
//  MusicDetailRouter.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import UIKit

class MusicDetailRouter: MusicDetailRouterProtocol {
    
    func navigateBackToListViewController(from view: MusicDetailViewProtocol) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        viewVC.navigationController?.popViewController(animated: true)
    }
    
    static func createTodoDetailRouterModule(with song: Results) -> UIViewController {
        let musikDetailVC = MusicDetailViewController()
        let presenter: MusicDetailPresenter & MusicDetailInteractorOutputProtocol = MusicDetailPresenter()
        let network: MusicListNetworkProtocol = MusicListNetwork()
        musikDetailVC.presenter = presenter
        presenter.view = musikDetailVC
        let interactor: MusicDetailInteractorInputProtocol = MusicDetailInteractor()
        interactor.songItem = song
        interactor.presenter = presenter
        interactor.network = network 
        presenter.interactor = interactor
        let router: MusicDetailRouterProtocol = MusicDetailRouter()
        presenter.router = router
        
        return musikDetailVC
    }
    
}
