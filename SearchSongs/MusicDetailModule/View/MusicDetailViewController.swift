//
//  MusicDetailViewController.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import UIKit
import SDWebImage

class MusicDetailViewController: UIViewController {
    var presenter: MusicDetailPresenterProtocol?
    
    var imagePreview: UIImageView = {
    let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "previewImage")
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.backgroundColor = .black
    return image
    }()
   private var volumePlus: UIImageView = {
    let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .lightGray
        image.image = UIImage(systemName: "speaker.wave.3.fill")
    return image
    }()
    private var volumeMinus: UIImageView = {
     let image = UIImageView()
         image.translatesAutoresizingMaskIntoConstraints = false
         image.tintColor = .lightGray
         image.image = UIImage(systemName: "speaker.fill")
     return image
     }()
// MARK: - UILabel
    private  var titleLabel: UILabel = {
    let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20,
                                       weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
    return label
  }()
    private var descriptionLabel: UILabel = {
    let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,
                                       weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
    return label
  }()
    private var timeLabel: UILabel = {
    let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15,
                                       weight: .semibold)
        label.textColor = .lightGray
        label.text = "00:00"
    return label
  }()
    private  var decreasingTimeLabel: UILabel = {
    let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15,
                                       weight: .semibold)
        label.textColor = .lightGray
        label.text = "-00:00"
    return label
  }()
// MARK: - UISlider
    private let progressBar: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .lightGray
        return slider
    }()
    private let volume: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .lightGray
        return slider
    }()
// MARK: - UIButton
    private var previousButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "backward.fill"),
                                  for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    private var playPauseButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "play.fill"),
                                  for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    private var nextButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "forward.fill"),
                                  for: .normal)
        button.tintColor = .lightGray
        return button
    }()
// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupeViews()
        setupeSlider()
        setupePleerButton()
        setupeConstraint()
        presenter?.viewDidLoad()
    }
// MARK: - setupeViews
    private func setupeViews() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(imagePreview)
        view.addSubview(progressBar)
        view.addSubview(playPauseButton)
        view.addSubview(nextButton)
        view.addSubview(previousButton)
        view.addSubview(volume)
        view.addSubview(timeLabel)
        view.addSubview(decreasingTimeLabel)
        view.addSubview(volumePlus)
        view.addSubview(volumeMinus)
    }
// MARK: - setupeSlider
    private func setupeSlider() {
        progressBar.addTarget(self,
                         action: #selector(playbackProgress),
                         for: .valueChanged)
        volume.addTarget(self,
                         action: #selector(didVolume),
                         for: .touchUpInside)
    }
    @objc func playbackProgress(sender: UISlider) {
        presenter?.didSelecPlaybackProgress(sender: sender)
    }
    @objc func didVolume(sender: UISlider) {
        presenter?.didSelecoVolume(sender: sender)
    }
// MARK: - setupePleerButton
    private func setupePleerButton() {
        playPauseButton.addTarget(self,
                                  action: #selector(didPlayPause),
                                  for: .touchUpInside)
        nextButton.addTarget(self,
                             action: #selector(didNextTrack),
                             for: .touchUpInside)
        previousButton.addTarget(self,
                             action: #selector(didPreviousTrack),
                             for: .touchUpInside)
    }
    @objc func didPlayPause(sender: UIButton) {
            if playPauseButton.currentBackgroundImage == UIImage(systemName: "play.fill") {
                playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"),
                                                   for: .normal)
                presenter?.didSelecPlayButton()
            } else {
                playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"),
                                                   for: .normal)
                presenter?.didSelecPauseButton()
            }
        }
    @objc func didNextTrack(sender: UIButton) {
        presenter?.didSelecNextButton(sender: sender)
    }
    @objc func didPreviousTrack(sender: UIButton) {
        presenter?.didSelecPreviousButton(sender: sender)
    }
// MARK: - setupeConstraint
    private func setupeConstraint() {
        NSLayoutConstraint.activate([
            imagePreview.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            imagePreview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePreview.widthAnchor.constraint(equalToConstant: 350),
            imagePreview.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 300),
            descriptionLabel.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.widthAnchor.constraint(equalToConstant: 350),
            progressBar.heightAnchor.constraint(equalToConstant: 30),
            progressBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            timeLabel.widthAnchor.constraint(equalToConstant: 60),
            timeLabel.heightAnchor.constraint(equalToConstant: 30),
            timeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -230)
        ])
        
        NSLayoutConstraint.activate([
            decreasingTimeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
            decreasingTimeLabel.widthAnchor.constraint(equalToConstant: 60),
            decreasingTimeLabel.heightAnchor.constraint(equalToConstant: 30),
            decreasingTimeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -230)
        ])
        
        NSLayoutConstraint.activate([
            previousButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70),
            previousButton.widthAnchor.constraint(equalToConstant: 60),
            previousButton.heightAnchor.constraint(equalToConstant: 40),
            previousButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -155)
        ])
        
        NSLayoutConstraint.activate([
            playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playPauseButton.widthAnchor.constraint(equalToConstant: 50),
            playPauseButton.heightAnchor.constraint(equalToConstant: 50),
            playPauseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
      
        NSLayoutConstraint.activate([
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            nextButton.widthAnchor.constraint(equalToConstant: 60),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
        NSLayoutConstraint.activate([
            volume.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            volume.widthAnchor.constraint(equalToConstant: 280),
            volume.heightAnchor.constraint(equalToConstant: 30),
            volume.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        ])
        
        NSLayoutConstraint.activate([
            volumePlus.leftAnchor.constraint(equalTo: volume.rightAnchor, constant: 10),
            volumePlus.widthAnchor.constraint(equalToConstant: 15),
            volumePlus.heightAnchor.constraint(equalToConstant: 15),
            volumePlus.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75)
        ])
        
        NSLayoutConstraint.activate([
            volumeMinus.rightAnchor.constraint(equalTo: volume.leftAnchor, constant: -10),
            volumeMinus.widthAnchor.constraint(equalToConstant: 15),
            volumeMinus.heightAnchor.constraint(equalToConstant: 15),
            volumeMinus.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75)
        ])
    }
}
extension MusicDetailViewController: MusicDetailViewProtocol {
    func showSong(song: Results) {
        titleLabel.text = song.artistName
        descriptionLabel.text = song.trackName
        guard let url = URL(string: song.artworkUrl100 ?? "") else { return }
        imagePreview.sd_setImage(with: url,
                                 placeholderImage: UIImage(systemName: "magnifyingglass"))
    }
}
