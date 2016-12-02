//
//  GifSearchViewController.swift
//  giphysearch
//
//  Created by Eduardo Pinto on 01/12/16.
//  Copyright © 2016 Eduardo Pinto. All rights reserved.
//

import UIKit

class GifSearchViewController: UIViewController, GifView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var gifs : [GifDisplay] = []
    var gifPresenter : GifPresenter!
    
    let gifCellIdentifier : String = "gifCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "GifTableViewCell", bundle: nil), forCellReuseIdentifier: gifCellIdentifier)
        
        self.loadingView.isHidden = true
        
        self.searchTextField.delegate = self
        
        self.gifPresenter.searchGifs(query: self.searchTextField.text!)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table View Delegate/Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return self.gifs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: gifCellIdentifier, for: indexPath) as! GifTableViewCell
        let gifDisplay = self.gifs[indexPath.row]
        
        cell.configureGifCell(gifUrl: gifDisplay.imageUrl, source: gifDisplay.source, date: gifDisplay.date)
        
        return cell
    }
    
    // MARK: - GifView Protocol
    func startLoading() {
        self.loadingView.isHidden = false;
    }
    
    func finishLoading() {
        self.loadingView.isHidden = true;
    }
    
    func setSearchResult(gifs: [GifDisplay]) {
        self.gifs = gifs
        tableView.reloadData()
    }
    
    func setSearchError(error: String) {
        
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Text Field Delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        self.gifPresenter.searchGifs(query: textField.text!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
