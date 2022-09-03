//
//  DetailHeroController.swift
//  WallaMarvel
//
//  Created by Alena's macbook on 01.09.2022.
//

import UIKit

final class DetailHeroViewController: UIViewController, UITableViewDelegate {

    // MARK: Properties
    
    var presenter: DetailsHeroPresenterProtocol?
    var detailHeroProvider: DetailHeroAdapter?

    // MARK: life cycle
    
    override func loadView() {
        view = DetailHeroView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailHeroProvider = DetailHeroAdapter(hero: nil, view: view as! DetailHeroView)
        
        // simple example with first url in array:
        // urls (Array[Url], optional): A set of public web site URLs for the resource.,
        (view as! DetailHeroView).resourceURLsView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                     action: #selector(linkTapped(_:))))
        
        presenter?.ui = self
    }
    
    @objc func linkTapped(_ sender: UITapGestureRecognizer) {
        guard let url = detailHeroProvider?.url else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    
}

// MARK: DetailsHeroUI

extension DetailHeroViewController: DetailsHeroUI {
    
    func update(hero: CharacterDataModel) {
        detailHeroProvider?.hero = hero
        
        DispatchQueue.main.async {
            self.title = hero.name
        }
        
    }

}

