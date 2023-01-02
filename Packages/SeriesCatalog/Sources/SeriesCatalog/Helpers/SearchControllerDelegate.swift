import UIKit
import Combine

final class SearchControllerDelegate: NSObject {
    @Published private(set) var searchText = ""
    @Published private(set) var isActive = false
}

extension SearchControllerDelegate: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchText = ""
        isActive = false
    }
}

extension SearchControllerDelegate: UISearchControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        isActive = true
    }
}
