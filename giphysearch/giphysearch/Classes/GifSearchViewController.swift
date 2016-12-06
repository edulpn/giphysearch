//
//  GifSearchViewController.swift
//  giphysearch
//
//  Created by Eduardo Pinto on 01/12/16.
//  Copyright © 2016 Eduardo Pinto. All rights reserved.
//

import UIKit

class GifSearchViewController: UIViewController, GifView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var gifs : [GifDisplay] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var gifPresenter : GifPresenter?
    
    let gifCellIdentifier : String = "gifCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "GifTableViewCell", bundle: nil), forCellReuseIdentifier: gifCellIdentifier)
        
        loadingView.isHidden = true
        
        searchTextField.delegate = self
        
        guard (gifPresenter != nil) else {
            
            //We reached a place where the presenter dependency should be already injected, so return
            return
        }
        
        gifPresenter!.searchGifs(query: self.searchTextField.text!)
    }
    
    // MARK: - Table View Delegate/Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return gifs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: gifCellIdentifier, for: indexPath) as! GifTableViewCell
        let gifDisplay = gifs[indexPath.row]
        
        cell.configureGifCell(gifUrl: gifDisplay.imageUrl, source: gifDisplay.source, date: gifDisplay.date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200.0
    }
    
    // MARK: - GifView Protocol
    func startLoading() {
        loadingView.isHidden = false;
    }
    
    func finishLoading() {
        loadingView.isHidden = true;
    }
    
    func setSearchResult(gifs: [GifDisplay]) {
        
        self.gifs = gifs
    }
    
    func setSearchError(error: String) {
        
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: {})
        }))
        
        present(alert, animated: true, completion: {})
    }
    
    func setSearchEmpty (message: String) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: {})
        }))
        
        present(alert, animated: true, completion: {})
    }
    
    // MARK: - Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard (gifPresenter != nil) else {
            
            //Again, the presenter dependency should be already injected, so return
            return
        }
        
        gifPresenter!.searchGifs(query: textField.text!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
