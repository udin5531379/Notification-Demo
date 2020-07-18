//
//  NotificationsViewController.swift
//  n otification-demo
//
//  Created by Udin Rajkarnikar on 9/27/18.
//  Copyright © 2018 Udin Rajkarnikar. All rights reserved.
//

import UIKit

class NotificationsViewController: UITableViewController {

   var missedNotificationsArray = [missNotificationsArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON()
    }
    
    struct missNotificationsArray: Decodable {
        
        let cId: Int
        let number: String
        let incomingTime: String
        let status: String
        
    }

    fileprivate func fetchJSON(){
    
        let urlString = "http://192.168.1.33:8080/getMissedCall"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) {(data, _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    
                    print("Failed to get data From url: ", err)
                    return
                    
                }
                
                guard let data = data else { return }
                
                do {
                    
                    let decoder = JSONDecoder()
                    self.missedNotificationsArray = try decoder.decode([missNotificationsArray].self, from: data)
                    self.tableView.reloadData()
                    
                } catch let jsonErr {
                    
                    print("Failed to Decode: ", jsonErr)
                    
                }
            }
        }.resume()
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return missedNotificationsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let notification = missedNotificationsArray[indexPath.row]
        cell.textLabel?.text = notification.number
        cell.detailTextLabel?.text = notification.status
        
        return cell
     
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "details") as? ViewController
//        
//         let notification = missedNotificationsArray[indexPath.row]
//        
//        vc?.missedNumber = notification.number
//        
//        self.navigationController?.pushViewController(vc!, animated: true)

    }



}
