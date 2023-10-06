//
//  MusicListCell.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import UIKit
import SDWebImage

class MusicListCell: UITableViewCell {
    
    // MARK: - UILabel
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15,
                                 weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15,
                                 weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    // MARK: - UIImageView
   private var imagePreview: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 5
        image.backgroundColor = .black
        image.clipsToBounds = true
        return image
    }()
    // MARK: - configuration
    func configuration(songItem: Results) {
        titleLabel.text = songItem.trackName
        descriptionLabel.text = songItem.artistName
        guard let url = URL(string: songItem.artworkUrl60 ?? "") else { return }
        imagePreview.sd_setImage(with: url,
                                 placeholderImage: UIImage(systemName: "magnifyingglass"))
    }
    // MARK: - init
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(imagePreview)
        setupeConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setupeConstraint
    private func setupeConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: imagePreview.rightAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 350),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: imagePreview.rightAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 350),
            
            imagePreview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imagePreview.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            imagePreview.widthAnchor.constraint(equalToConstant: 50),
            imagePreview.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
