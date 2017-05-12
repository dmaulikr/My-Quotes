//
//  ViewController.swift
//  MotivationQuotes
//
//  Created by Ty rainey on 5/9/17.
//  Copyright © 2017 Ty rainey. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications



@available(iOS 10.0, *)
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var quotes: [[String:AnyObject]] = [[String:AnyObject]]()
    var isLoading = false
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLoading == false {
            moodAlert()
           isLoading = true
        }
      
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteTableViewCell", for: indexPath) as! QuoteTableViewCell
        
        let quote = quotes[indexPath.row]
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
    
    @available(iOS 10.0, *)
    func registerLocal() {
        let center = UNUserNotificationCenter.current
        
        center().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    
 
    @available(iOS 10.0, *)
    func scheduleLocal() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Need some motivation?"
        content.body = "Somehow get quote here"
        content.categoryIdentifier = "details"
        content.userInfo = ["quotes": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        var dateComponents = DateComponents()
        dateComponents.hour = 6
        dateComponents.minute = 52
       //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
    }

    func moodAlert() {
        
        
        let alert = UIAlertController(title: "Hi!, How are you feeling today?", message: "Please select a mood.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Happy", style: .default) { (action) in
            
             self.getQuotesFromService()
            
            }
        let secondAction = UIAlertAction(title: "Sad", style: .default) { (action) in
            
             self.getQuotesFromService()
                
            }
        let thirdAction = UIAlertAction(title: "Motivated", style: .default) { (action) in
            
            self.getQuotesFromService()
            
        }
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
            
            
            
            let datePicker: UIDatePicker = UIDatePicker()
            
            // Posiiton date picket within a view
            datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)
            
            // Set some of UIDatePicker properties
            datePicker.timeZone = NSTimeZone.local
            datePicker.backgroundColor = UIColor.white
            
            // Add an event to call onDidChangeDate function when value is changed.
            datePicker.addTarget(self, action: #selector(ViewController.datePickerValueChanged(_:)), for: .valueChanged)
            
            // Add DataPicker to the view
            self.view.addSubview(datePicker)
            
            
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        
        alert.addAction(action)
        alert.addAction(secondAction)
        alert.addAction(thirdAction)
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
       
        
        present(alert, animated: true, completion: nil)
    }
    
    func getQuotesFromService() {
        
        Alamofire.request("https://apimk.com/motivationalquotes?get_all_quote=yes").responseJSON { response in
            
            switch response.result {
            case .success:
                self.quotes = response.result.value as! [[String:AnyObject]]
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        print("Selected value \(selectedDate)")
    }

}


