import UIKit

final class ListHeroesViewController: UIViewController, UISearchResultsUpdating {
    
    enum Constant {
        static let sectionIndex = 0
    }
    
    var mainView: ListHeroesView { return view as! ListHeroesView  }
    
    var presenter: ListHeroesPresenterProtocol?
    var listHeroesProvider: ListHeroesAdapter?
    var searchController: UISearchController!
    var filterString: String? = nil
    
    override func loadView() {
        view = ListHeroesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listHeroesProvider = ListHeroesAdapter(tableView: mainView.heroesTableView)
        presenter?.getNextHeroes()
        presenter?.ui = self
        
        title = presenter?.screenTitle()
        
        mainView.heroesTableView.delegate = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        mainView.heroesTableView.tableHeaderView = searchController.searchBar

        definesPresentationContext = true
    }
}

extension ListHeroesViewController: ListHeroesUI {
    
    func update(heroes: [CharacterDataModel]?, shouldDeletePrevious: Bool) {
    
        guard let newArray = heroes else {
            if shouldDeletePrevious {
                listHeroesProvider?.heroes = []
            }
            return
        }
        
        if shouldDeletePrevious {
            listHeroesProvider?.heroes! = newArray
            
        } else {
            listHeroesProvider?.heroes! += newArray
        }
        
    }
    
}

extension ListHeroesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let hero = listHeroesProvider?.heroes?[indexPath.row]
        guard let heroID = hero?.id else {
            return
        }
        
        let presenter = DetailsHeroPresenter()
        
        let vc = DetailHeroViewController()
        vc.presenter = presenter
        vc.presenter?.getHeroDetails(heroID: "\(heroID)")
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: Constant.sectionIndex) - 1
            && filterString == nil {
            presenter?.getNextHeroes()
        }
    }
    
}

extension ListHeroesViewController {
    
    func updateSearchResults(for searchController: UISearchController) {

        if !searchController.isActive {
            return
        }

        if let searchString = searchController.searchBar.text, !searchString.isEmpty {
            filterString = searchController.searchBar.text
        } else {
            filterString = nil
        }
        
        presenter?.getHeroesByName(searchString: filterString)
        
    }
    
}
