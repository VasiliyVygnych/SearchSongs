//
//  MusicListRouter.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import UIKit

class MusicListRouter: MusicListRouterProtocol {
    static func createTodoListModule() -> UIViewController {
        let viewController = MusicListViewController()
        let navController = UINavigationController(rootViewController: viewController)
        let presenter: MusicListPresenterProtocol & MusicListInteractorOutputProtocol = MusicListPresenter()
        let interactor: MusicListInteractorInputProtocol = MusicListInteractor()
        let router = MusicListRouter()
        let network: MusicListNetworkProtocol = MusicListNetwork()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor 
        presenter.router = router
        interactor.presenter = presenter
        interactor.network = network
        return navController
    }
    func presentToDoDetailScreen(from view: MusicListViewProtocol,
                                 for song: Results) {
        let todoDetailVC = MusicDetailRouter.createTodoDetailRouterModule(with: song)
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        viewVC.navigationController?.pushViewController(todoDetailVC,
                                                        animated: true)
    }
}
