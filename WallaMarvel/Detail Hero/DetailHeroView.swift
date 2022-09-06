//
//  DetailHeroView.swift
//  WallaMarvel
//
//  Created by Alena's macbook on 01.09.2022.
//

import Foundation
import UIKit
import Kingfisher

final class DetailHeroView: UIView {
    
    // MARK: Constants
    
    enum Constant {
        static let offset: CGFloat = 20
        static let resourcesHeight: CGFloat = 50
        static let titleFont = UIFont.boldSystemFont(ofSize: 22)
        static let desciptionFont = UIFont.italicSystemFont(ofSize: 15)
        static let linkFont = UIFont.systemFont(ofSize: 17.0)
        static let comicsListTitleText = "Comics list"
        static let comicListScrollHeight = 100
    }
    
    // MARK: Views
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let heroNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constant.titleFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heroDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constant.desciptionFont
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resourceURLsView: UITextView = {
        let resourcesURLView = UITextView()
        resourcesURLView.translatesAutoresizingMaskIntoConstraints = false
        resourcesURLView.isEditable = false
        resourcesURLView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        return resourcesURLView
    }()
    
    private let modifiedDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constant.desciptionFont
        label.textColor = .systemGray2
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mainInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: life cycle
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        addSubviews()
        addContraints()
    }
    
    private func addSubviews() {
        mainInfoStackView.addSubview(heroImageView)
        mainInfoStackView.addSubview(heroNameLabel)
        mainInfoStackView.addSubview(heroDescriptionLabel)
        mainInfoStackView.addSubview(resourceURLsView)
        mainInfoStackView.addSubview(modifiedDateLabel)
        
        addSubview(mainInfoStackView)
    }
    
    private func addContraints() {

        NSLayoutConstraint.activate([
            
            mainInfoStackView.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constant.offset),
            mainInfoStackView.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: Constant.offset),
            mainInfoStackView.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -Constant.offset),
            
            heroImageView.centerXAnchor
                .constraint(equalTo: mainInfoStackView.centerXAnchor),
            heroImageView.topAnchor
                .constraint(equalTo: mainInfoStackView.topAnchor, constant: Constant.offset),
                
            heroNameLabel.topAnchor
                .constraint(equalTo: heroImageView.bottomAnchor, constant: Constant.offset),
            heroNameLabel.leadingAnchor.constraint(equalTo: mainInfoStackView.leadingAnchor),
            heroNameLabel.trailingAnchor.constraint(equalTo: mainInfoStackView.trailingAnchor),
                
            heroDescriptionLabel.topAnchor
                .constraint(equalTo: heroNameLabel.bottomAnchor, constant: Constant.offset),
            heroDescriptionLabel.leadingAnchor
                .constraint(equalTo: mainInfoStackView.leadingAnchor),
            heroDescriptionLabel.trailingAnchor
                .constraint(equalTo: mainInfoStackView.trailingAnchor),
            heroDescriptionLabel.bottomAnchor
                .constraint(equalTo: heroDescriptionLabel.bottomAnchor, constant: Constant.offset),
            
            resourceURLsView.topAnchor
                .constraint(equalTo: heroDescriptionLabel.bottomAnchor, constant: Constant.offset),
            resourceURLsView.leadingAnchor
                .constraint(equalTo: mainInfoStackView.leadingAnchor),
            resourceURLsView.trailingAnchor
                .constraint(equalTo: mainInfoStackView.trailingAnchor),
            resourceURLsView.heightAnchor
                .constraint(equalToConstant: Constant.resourcesHeight),
            
            modifiedDateLabel.topAnchor
                .constraint(equalTo: resourceURLsView.bottomAnchor, constant: Constant.offset),
            modifiedDateLabel.leadingAnchor
                .constraint(equalTo: mainInfoStackView.leadingAnchor),
            modifiedDateLabel.trailingAnchor
                .constraint(equalTo: mainInfoStackView.trailingAnchor),
            modifiedDateLabel.bottomAnchor
                .constraint(equalTo: modifiedDateLabel.bottomAnchor, constant: Constant.offset),
        ])
    }
    
    func configure(model: CharacterDataModel?) {
        
        guard let hero = model else {
            // empty view
            return
        }
        
        heroNameLabel.text = hero.name
        heroDescriptionLabel.text = hero.description
        
        if let resource = hero.link() {
            resourceURLsView.textStorage.setAttributedString(resource)
            resourceURLsView.attributedText = resource
        }
        
        if let thumbnail = hero.thumbnail {
            heroImageView.kf.setImage(with: URL(string: thumbnail.path + "/landscape_xlarge." + thumbnail.extension))
        }
        
        if let modifiedDate = hero.modifiedDate() {
            modifiedDateLabel.text = "Modified date: " + modifiedDate
        }
        
    }
    
}
