//
//  MainViewController.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/13/21.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    let networkManager = NetworkManager()
    var photos = [Photo]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flickr API"
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "PhotoInfoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PhotoInfoTableViewCell.cellId)
        tableView.separatorColor = .clear
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoInfoTableViewCell.cellId, for: indexPath) as? PhotoInfoTableViewCell
        else {
            fatalError("Can not find cell with id: \(PhotoInfoTableViewCell.cellId) at indexPath: \(indexPath)")
        }
        
        let photo = photos[indexPath.row]
        cell.update(with: photo, cellTag: indexPath.row)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard
            let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        else { return }
        
        let photo = photos[indexPath.row]
        detailVC.photo = photo
        
        show(detailVC, sender: nil)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.replacingOccurrences(of: " ", with: "+").lowercased()
        
        func reloadData(_ data: [Photo]?) {
            photos = data ?? []
            tableView.reloadData()
        }
        
        networkManager.loadPhotoInfo(text: text) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let result):
                reloadData(result.collection?.photos)
            case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
