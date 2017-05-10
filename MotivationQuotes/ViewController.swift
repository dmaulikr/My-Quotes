//
//  ViewController.swift
//  MotivationQuotes
//
//  Created by Ty rainey on 5/9/17.
//  Copyright © 2017 Ty rainey. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var quotes: [[String:AnyObject]] = [[String:AnyObject]]()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        Alamofire.request("https://apimk.com/motivationalquotes?get_all_quote=yes").responseJSON { response in
          
            switch response.result {
            case .success:
                self.quotes = response.result.value as! [[String:AnyObject]]
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                }
            }
        }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteTableViewCell", for: indexPath) as! QuoteTableViewCell
        
        let quote = self.quotes[indexPath.row]
        cell.quoteLabel.text =  quote["quote"] as? String
        cell.categoryLabel.text = quote["category"] as? String
        cell.authorLabel.text = quote["author_name"] as? String
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        let maindata = quotes[indexPath.row]
        let myVC = storyboard?.instantiateViewController(withIdentifier: "details") as! DetailViewController
        myVC.quotePassed = maindata["quote"] as! String
        myVC.authorPassed = maindata["author_name"] as! String
        myVC.categoryPassed = maindata["category"] as! String
        navigationController?.pushViewController(myVC, animated: true)
        
        }

    }


