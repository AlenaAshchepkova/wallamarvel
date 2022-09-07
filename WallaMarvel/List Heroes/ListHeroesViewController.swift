import UIKit

final class ListHeroesViewController: UIViewController, UISearchResultsUpdating {
    
    enum Constant {
        static let sectionIndex = 0
    }
    
    var mainView: ListHeroesView { return view as! ListHeroesView  }
    
    var presenter: ListHeroesPresenterProtocol?
    var listHeroesProvider: ListHeroesAdapter?
    var searchController: UISearchController!
    var filterString: String? = nil {
        willSet(newValue) {
            if newValue == nil {
                presenter?.deleteSearchData()
                presenter?.reloadHeroes()
                
            } else {
                
                if let filter = filterString {
                    if filter.elementsEqual(newValue!) {
                        presenter?.getHeroesByName(searchString: newValue!)
                        return
                    }
                }
                presenter?.deleteSearchData()
                presenter?.getHeroesByName(searchString: newValue!)
            }
        }
    }

    override func loadView() {
        view = ListHeroesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.ui = self
        listHeroesProvider = ListHeroesAdapter(tableView: mainView.heroesTableView)

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
    
    func update(heroes: [CharacterDataModel]?) {
    
        guard let newArray = heroes else {
            listHeroesProvider?.heroes = []
            return
        }
        
        listHeroesProvider?.heroes! = newArray
        
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
        if indexPath.row == tableView.numberOfRows(inSection: Constant.sectionIndex) - 1 {
            guard let filter = filterString, !filter.isEmpty else {
                presenter?.loadNextHeroes()
                return
            }
 
            presenter?.getHeroesByName(searchString: filter)
        }
    }
    
}

extension ListHeroesViewController {
    
    func updateSearchResults(for searchController: UISearchController) {

        if !searchController.isActive {
            presenter?.deleteSearchData()
            presenter?.reloadHeroes()
            return
        }

        if let searchString = searchController.searchBar.text, !searchString.isEmpty {
            filterString = searchString
            
        } else {
            filterString = nil
        }
    }
    
}
