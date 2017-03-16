//
//  FriendViewController.swift
//  FriendTime
//
//  Created by Jakob Haglöf on 2017-03-15.
//  Copyright © 2017 Jakob Haglöf. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {
    
    var firstNameOfFriend : String?
    var surNameOfFriend : String?
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var surNameLabel: UILabel!
    
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    var seconds = 0
    var minutes = 0
    var hours = 0
    var days = 0
    var timer = Timer()
    var friend : Friend?
    var timeSinceMeet : Double = 0
    
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
        
        DatabaseController.updateTime(friend: friend!)
        setupViewController()
        setTime()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func setupViewController() {
        
        let friend : Friend = DatabaseController.getSpecificFriend(firstName: firstNameOfFriend!, surName: surNameOfFriend!)!
        
        let time = Date()
        var timeSinceMeet : Double = time.timeIntervalSinceReferenceDate
        timeSinceMeet = timeSinceMeet - friend.timeSinceMeet
        
    }
    

}
