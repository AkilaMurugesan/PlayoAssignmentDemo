//
//  NewHomeVC.swift
//  PlayoAssignment
//
//  Created by Akila Arun on 7/15/22.
//

import UIKit
import SDWebImage
import ANLoader
import Foundation
import Reachability


class NewHomeVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewNotConnectedToInternet: UIView!
    @IBOutlet weak var btnTryAgain: UIButton!
    var url = ""
    var datasource: NewsListModel?
    lazy var refreshControl: UIRefreshControl = {
           let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NewHomeVC.handleRefresh(_:)), for: UIControl.Event.valueChanged)
           refreshControl.tintColor = UIColor(red: 0.29, green: 0.63, blue: 0.73, alpha: 1.00)
           
           return refreshControl
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnTryAgain.layer.cornerRadius = 10
        viewNotConnectedToInternet.layer.isHidden = true
        self.tblView.addSubview(self.refreshControl)
       }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Connectivity.isConnectedToInternet {
            viewNotConnectedToInternet.layer.isHidden = true
            triggerListAPI()
        }
        else{
            viewNotConnectedToInternet.layer.isHidden = false
        }
    }
    func triggerListAPI() {
        let session = URLSession.shared
        let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=5f6e278cc4c54e489634de27bf75a3a9")
       
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        ANLoader.showLoading("Loading", disableUI: false)
        ANLoader.activityBackgroundColor = UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00)
        let task = session.dataTask(with: request) { data, response, error in
            guard let jsonData = data, let productListModel = try? JSONDecoder().decode(NewsListModel.self, from: jsonData) else { return }
            self.datasource = productListModel
            DispatchQueue.main.async {
                self.tblView.reloadData()
                ANLoader.hide()
            }
        }
        task.resume()
    }
    @IBAction func btnTryAgain(_ sender: Any) {
        viewNotConnectedToInternet.layer.isHidden = true
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
           
            triggerListAPI()
            self.tblView.reloadData()
            refreshControl.endRefreshing()
        }
}


//MARK:- COOKING DATASOURCE & DELEGATES OF TABLEVIEW
extension NewHomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.datasource?.articles?.count)
        return self.datasource?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewsTableViewCell
        cell.viewCorner.layer.cornerRadius = 10
        if(self.datasource?.articles?[indexPath.row] != nil){
        let articles = self.datasource?.articles?[indexPath.row]
       
            if let title = articles?.title
            {
           cell.lbltitle.text = "\(title)"
            }
            if let author = articles?.author
            {
                cell.lblAuthorName.text = "\(author)"
            }
            if let articleDescription = articles?.articleDescription
            {
                cell.lbldescription.text = "\(articleDescription)"
            }
            if let urlToImage = articles?.urlToImage
            {
                cell.imgNews.sd_setImage(with: NSURL(string: (urlToImage)) as URL?, placeholderImage:UIImage(named:"news"))
            }
            cell.imgNews.roundCorners(corners: [.bottomRight, .bottomLeft], radius: 10)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let NewsDetailsVC = storyBoard.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsVC
            let articles = self.datasource?.articles?[indexPath.row]
            if let url = articles?.url
            {
               NewsDetailsVC.url = "\(url)"
            }
            self.present(NewsDetailsVC, animated: true, completion: nil)
    }
}
