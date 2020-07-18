//
//  TableViewControllerfinal.swift
//  n otification-demo
//
//  Created by Udin Rajkarnikar on 10/25/18.
//  Copyright © 2018 Udin Rajkarnikar. All rights reserved.
//

import UIKit
import SVProgressHUD
import UserNotifications

class TableViewControllerfinal: UITableViewController {

    let sc = UISegmentedControl(items: ["Missed","Received"])
    
    var missedNotificationsArray = [missNotificationsArray]()
    var recivedCallsArray = [receiveCallArray]()
    
    
    func notification(){
        
        let content = UNMutableNotificationContent()
        content.title = "Missed Calls"
        content.body = "Open app to view the missed calls"
        content.sound = UNNotificationSound.default
        
        
        let random = Int.random(in: 600...2000)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(random), repeats: true)
        
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.show()
        
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.layer.cornerRadius = 3
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        navigationItem.titleView = sc
        
        let companyLogo = UIButton(type: .custom)
        companyLogo.setImage(UIImage(named: "logofinal"), for: .normal)
        companyLogo.contentMode = .scaleAspectFill
        companyLogo.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        companyLogo.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        companyLogo.isUserInteractionEnabled = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: companyLogo)
        
        let rightVerticalThreeDots = UIButton(type: .custom)
        rightVerticalThreeDots.setImage(UIImage(named: "rightItem"), for: .normal)
        rightVerticalThreeDots.contentMode = .scaleAspectFill
        rightVerticalThreeDots.widthAnchor.constraint(equalToConstant: 23.0).isActive = true
        rightVerticalThreeDots.heightAnchor.constraint(equalToConstant: 23.0).isActive = true
        rightVerticalThreeDots.addTarget(self, action: #selector(threeDotsButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightVerticalThreeDots)
        
        navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 38/255, green: 44/255, blue: 61/255, alpha: 1)
        
        let nibName = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CustomCell")
        
        let nibName2 = UINib(nibName: "receivedCustomCell", bundle: nil)
        tableView.register(nibName2, forCellReuseIdentifier: "receivedCustomCell")
        
        fetchMiisedCallJSON()
        
        rightSwipe()
        leftSwipe()
     
      }
    
    @objc func threeDotsButtonPressed() {
    
        let alert = UIAlertController(title: "Are you sure you want to logout ?", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive , handler:{ (UIAlertAction)in
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    
    }
   
    @objc func handleLoginRegisterChange() {
        
        SVProgressHUD.show()
        notification()
        
        if sc.selectedSegmentIndex == 0 {
            //Calls Missed ko lagi
            
            
            fetchMiisedCallJSON()
            tableView.reloadData()
            
            
            
        } else if sc.selectedSegmentIndex == 1 {
            // calls received ko lagi
            
            
            fetchReceivedCallJSON()
            tableView.reloadData()
            
            
        }
        
    }
    
    func rightSwipe() {
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSWipped))
        rightSwipe.direction = .right
        self.tableView.addGestureRecognizer(rightSwipe)
        
    }
    
    @objc func rightSWipped(){
        
        notification()
        SVProgressHUD.show()
        // right swipe garyo bhaney missed ma jancha
        sc.selectedSegmentIndex = 0
        fetchMiisedCallJSON()
        tableView.reloadData()
        
        print("Swiped Right")
        
    }
    
    func leftSwipe() {
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSWipped))
        leftSwipe.direction = .left
        self.tableView.addGestureRecognizer(leftSwipe)
        
    }
    
    @objc func leftSWipped() {
        
        notification()
        SVProgressHUD.show()
        //left swipe garyo bhaney received ma jaancha
        sc.selectedSegmentIndex = 1
        fetchReceivedCallJSON()
        tableView.reloadData()
        print("left swipped")
        
        
    }
    
    struct missNotificationsArray: Decodable {
        
        let Queue_Member: String
        let Queue_Name: String
        let Ring_No_Answer: Int
        
    }
    
    fileprivate func fetchMiisedCallJSON(){
        
        
        let urlString = "http://18.223.3.41:8080/api/missedcallnotifier/ringNoAnswerPerUser"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    
                    SVProgressHUD.dismiss()
                    SVProgressHUD.show(withStatus: "Error in displaying data")
                    print("Failed to get data From url: ", err)
                    
                    return
                    
                }
                
                guard let data = data else { return }
                
                do {
                    
                    SVProgressHUD.dismiss()
                    let decoder = JSONDecoder()
                    self.missedNotificationsArray = try decoder.decode([missNotificationsArray].self, from: data)
                    self.tableView.reloadData()
                    
                } catch let jsonErr {
                    
                    SVProgressHUD.dismiss()
                    SVProgressHUD.show(withStatus: "JSON data error")
                    print("Failed to Decode: ", jsonErr)
                    
                }
            }
            }.resume()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sc.selectedSegmentIndex == 0 {
            
            return missedNotificationsArray.count
            
        } else {
            
            return recivedCallsArray.count
            
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
     }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if sc.selectedSegmentIndex == 0 {
            //Calls Missed ko lagi
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
            
            let notification = missedNotificationsArray[indexPath.row]
            
            
            let group = notification.Queue_Member
            let name = notification.Queue_Name
            let callsNotAnswered = notification.Ring_No_Answer
            
            cell.commonInit(_memberGroup: group, _memberName: name, _callsNotAnswered: callsNotAnswered)
            
            return cell
            
        } else {
            //calls reveceived ko lagi
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "receivedCustomCell", for: indexPath) as! receivedCustomCell
            
            let notification = recivedCallsArray[indexPath.row]
            
            
            let group = notification.Queue_Name
            let name = notification.Queue_Member
            let callsNotAnswered = notification.Completed
            
            cell.commonInitFromReceivedClass(_memberGroup: group, _memberName: name, _callsNotAnswered: callsNotAnswered)
            
            
            return cell
            
        }
        
        
        
    }
    
    struct receiveCallArray: Decodable {
        
        let Queue_Member: String
        let Queue_Name: String
        let Completed: Int
        
    }
    
    fileprivate func fetchReceivedCallJSON(){
        
        
        let urlString = "http://18.223.3.41:8080/api/missedcallnotifier/completedPerUser"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    
                    SVProgressHUD.dismiss()
                    SVProgressHUD.show(withStatus: "Failed to get data")
                    print("Failed to get data From url: ", err)
                    
                    return
                    
                }
                
                guard let data = data else { return }
                
                do {
                    
                    SVProgressHUD.dismiss()
                    let decoder = JSONDecoder()
                    self.recivedCallsArray = try decoder.decode([receiveCallArray].self, from: data)
                    self.tableView.reloadData()
                    
                } catch let jsonErr {
                    
                    SVProgressHUD.dismiss()
                    SVProgressHUD.show(withStatus: "Failed to decode")
                    print("Failed to Decode from received: ", jsonErr)
                    
                }
            }
            }.resume()
        
        
    }
        
    }

    

 


