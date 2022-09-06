import Foundation
import UIKit
import Kingfisher

final class ListHeroesTableViewCell: UITableViewCell {
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let heroName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        addContraints()
    }
    
    private func addSubviews() {
        addSubview(heroImageView)
        addSubview(heroName)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            heroImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            heroImageView.heightAnchor.constraint(equalToConstant: 80),
            heroImageView.widthAnchor.constraint(equalToConstant: 80),
            heroImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            heroName.leadingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: 12),
            heroName.topAnchor.constraint(equalTo: heroImageView.topAnchor, constant: 8),
        ])
    }
    
    func configure(model: CharacterDataModel) {
        heroName.text = model.name
        
        guard let thumbnail = model.thumbnail else {
            return
        }
        
        heroImageView.kf.setImage(with: URL(string: thumbnail.path + "/portrait_small." + thumbnail.extension))
    }
    
}
