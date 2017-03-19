//
//  FriendViewController.swift
//  FriendTime
//
//  Created by Jakob Haglöf on 2017-03-15.
//  Copyright © 2017 Jakob Haglöf. All rights reserved.
//

import UIKit
import CoreData

class FriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var meetingTableView: UITableView!
    var firstNameOfFriend : String?
    var surNameOfFriend : String?
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var surNameLabel: UILabel!
    
    
    @IBOutlet weak var meetingDescription: UITextField!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    var seconds = 0
    var minutes = 0
    var hours = 0
    var days = 0
    var timer = Timer()
    var timeSinceMeet : Double = 0
    
    var amountOfMeetings : [Meeting] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let nameOfPerson = ("\(firstNameOfFriend!)\(surNameOfFriend!)")
        let path = CameraController.imagePath(nameOfImage: nameOfPerson)
        
        
        profileImage.image = CameraController.getPicture(imagePath: path)
        firstNameLabel.text = firstNameOfFriend!
        surNameLabel.text = surNameOfFriend!
        
        setupViewController()
        
        
        print(Int(timeSinceMeet))
        
        (days, hours, minutes, seconds) = TimerHelper.convertFromSeconds(seconds: Int(timeSinceMeet))
        
        setTime()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(FriendViewController.counter), userInfo: nil, repeats: true)
        
    }
    
    func counter() {
        
        seconds += 1
        secondsLabel.text = String(seconds)
        
        if(seconds == 60) {
            
            seconds = 0
            secondsLabel.text = String(seconds)
            
            minutes += 1
            minutesLabel.text = String(minutes)
            
            if(minutes == 60) {
                
                minutes = 0
                minutesLabel.text = String(minutes)
                
                hours += 1
                hoursLabel.text = String(hours)
                
                if(hours == 24) {
                    
                    hours = 0
                    hoursLabel.text = String(hours)
                    
                    days += 1
                    daysLabel.text = String(days)
                }
            }
        }
        
    }
    
    func setTime() {
        
        secondsLabel.text = String(seconds)
        minutesLabel.text = String(minutes)
        hoursLabel.text = String(hours)
        daysLabel.text = String(days)
    }
    
    @IBAction func resetTime(_ sender: Any) {
        
        if(meetingDescription.text == "") {
            
            meetNotice(noticeTitle: "No meeting", noticeMessage: "Please type in what you two did!")
            
        } else {
            let friend : Friend = DatabaseController.getSpecificFriend(firstName: firstNameOfFriend!, surName: surNameOfFriend!)!
            
            DatabaseController.updateTime(friend : friend)
            
            setupViewController()
            
            addMeeting()
        }
        
    }
    
    func addMeeting() {
        
        let friend : Friend = DatabaseController.getSpecificFriend(firstName: firstNameOfFriend!, surName: surNameOfFriend!)!
        
        let meet:Meeting = NSEntityDescription.insertNewObject(forEntityName: "Meeting", into: DatabaseController.getContext()) as! Meeting
        
        meet.type = meetingDescription.text
        
        friend.addToRelationship(meet)
        
        print(friend.relationship!)
        meetNotice(noticeTitle: "Saved as:", noticeMessage: "Saved as: \(meetingDescription.text!)")
        
        DatabaseController.saveContext()
        
        amountOfMeetings.append(meet)
        
        self.meetingTableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func setupViewController() {
        
        let friend : Friend = DatabaseController.getSpecificFriend(firstName: firstNameOfFriend!, surName: surNameOfFriend!)!
        
        amountOfMeetings = DatabaseController.getAllMeetings(friend: friend)
        let time = Date()
        timeSinceMeet = time.timeIntervalSinceReferenceDate
        timeSinceMeet = timeSinceMeet - friend.timeSinceMeet
        
        (days, hours, minutes, seconds) = TimerHelper.convertFromSeconds(seconds: Int(timeSinceMeet))
        
        setTime()
        
    }
    
    func meetNotice(noticeTitle : String, noticeMessage : String) {
        
        let alertController = UIAlertController.init(title: noticeTitle, message: noticeMessage, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return amountOfMeetings.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = amountOfMeetings[indexPath.row].type!
        return cell
        
    }
}
