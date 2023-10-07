//
//  MusicListViewController.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import UIKit
//import SDWebImage

class MusicListViewController: UITableViewController {
    
    var presenter: MusicListPresenterProtocol?
    var searc = UISearchController(searchResultsController: nil)
    private var activityIndicator = UIActivityIndicatorView()
    private var timer: Timer?

    var soungs: SongData? {
        didSet {
            tableView.reloadData()
        }
    }
// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupeSearch()
        setupeIndicator()
    }
// MARK: - setupeSearch
    private func setupeSearch() {
        searc.searchResultsUpdater = self
        searc.hidesNavigationBarDuringPresentation = false
        self.navigationItem.titleView = searc.searchBar
    }
// MARK: - setupeIndicator
    private func setupeIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 300),
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
    }
// MARK: - setupView
    private func setupView() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.rowHeight = 70
        tableView.register(MusicListCell.self,
                           forCellReuseIdentifier: "cell")
    }
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return soungs?.results.count ?? 0
    }
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as? MusicListCell,
        let song = soungs?.results[indexPath.row] else { return UITableViewCell() }
        cell.configuration(songItem: song)
        activityIndicator.stopAnimating()
        return cell
    }
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        guard let song = soungs?.results[indexPath.row] else { return }
        presenter?.didSelectRowAt(song: song)
    }
}
// MARK: - extension MusicListViewProtocol
extension MusicListViewController: MusicListViewProtocol {
    func showSongs(songs: SongData?) {
        self.soungs = songs
    }
}
// MARK: - extension saerch
extension MusicListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.count > 2 {
            timer?.invalidate()
            activityIndicator.startAnimating()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0,
                                         repeats: false,
                                         block: { (_) in
                self.presenter?.getSearchText(text: searchText)
            })
        }
    }
}
