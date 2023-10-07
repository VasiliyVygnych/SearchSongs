//
//  MusicDetailViewController.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import UIKit
import SDWebImage
import MediaPlayer

class MusicDetailViewController: UIViewController {
    var presenter: MusicDetailPresenterProtocol?
    private var player: AVPlayer?

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
    return label
  }()
// MARK: - UISlider
    private let progressBar: UISlider = {
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
        view.addSubview(timeLabel)
    }
// MARK: - setupeSlider
    private func setupeSlider() {
        progressBar.addTarget(self,
                         action: #selector(playbackProgress),
                         for: .valueChanged)
    }
    @objc func playbackProgress(sender: UISlider) {
        player?.seek(to: CMTime(seconds: Double(progressBar.value), preferredTimescale: 1000))
        self.timeLabel.text = String(progressBar.value)
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
                    player?.play()
            } else {
                playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"),
                                                   for: .normal)
                    player?.pause()
            }
        }
    @objc func didNextTrack(sender: UIButton) {
        //
    }
    @objc func didPreviousTrack(sender: UIButton) {
        //
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
            timeLabel.widthAnchor.constraint(equalToConstant: 100),
            timeLabel.heightAnchor.constraint(equalToConstant: 30),
            timeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -230)
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
    }
}
extension MusicDetailViewController: MusicDetailViewProtocol {
    func showSong(song: Results) {
        titleLabel.text = song.artistName
        descriptionLabel.text = song.trackName
        guard let urlImage = URL(string: song.artworkUrl100 ?? "") else { return }
        imagePreview.sd_setImage(with: urlImage,
                                 placeholderImage: UIImage(systemName: "magnifyingglass"))
        guard let urlSong = URL(string: song.previewUrl) else { return }
        player = AVPlayer(url: urlSong)
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1,
                                                            preferredTimescale: 1000),
                                        queue: DispatchQueue.main,
                                        using: { time in
            let formater = NumberFormatter()
            formater.decimalSeparator = ":"
            formater.maximumFractionDigits = 1
            formater.minimumFractionDigits = 1
            let formattedTimer = formater.string(from: NSNumber(value: time.seconds))
            self.timeLabel.text = formattedTimer
            self.progressBar.value = Float(time.seconds)
            self.progressBar.maximumValue = Float(self.player?.currentItem?.duration.seconds ?? 0)
        })
    }
}
