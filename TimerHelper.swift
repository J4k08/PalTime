//
//  TimerHelper.swift
//  FriendTime
//
//  Created by Jakob Haglöf on 2017-03-15.
//  Copyright © 2017 Jakob Haglöf. All rights reserved.
//

import Foundation


class TimerHelper {
    
    private init() {
        
    }
    
    class func convertFromSeconds(seconds : Int) -> (Int, Int, Int, Int) {
        
        var secondsLeft = seconds
        var returnSeconds = 0
        var returnMinutes = 0
        var returnHours = 0
        var returnDays = 0
        
        if(seconds >= 86400) {
            returnDays = seconds / 86400
            secondsLeft = seconds % 86400
        }
        if(secondsLeft >= 3600) {
            returnHours = secondsLeft / 3600
            secondsLeft = secondsLeft % 3600
        }
        if(secondsLeft >= 60) {
            returnMinutes = secondsLeft / 60
            returnSeconds = secondsLeft % 60
        }else {
            returnSeconds = secondsLeft
        }
        
        return (returnDays, returnHours, returnMinutes, returnSeconds)
        
    }
    

    
    
    
}
