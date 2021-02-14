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
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "PhotoInfoTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: PhotoInfoTableViewCell.cellId)
        
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
        
        cell.photoImageView.image = nil
        cell.titleLabel.text = nil
        let photo = photos[indexPath.row]
        cell.update(with: photo)
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.replacingOccurrences(of: " ", with: "+").lowercased()
        
        networkManager.loadPhotoInfo(text: text) { [weak self] (result, error) in
            if !text.isEmpty {
                guard
                    let self = self,
                    let result = result?.photos?.photo
                else { print(error as Any)
                    return }
                
                self.photos = result
                self.tableView.reloadData()
            } else {
                self?.photos = []
                self?.tableView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

