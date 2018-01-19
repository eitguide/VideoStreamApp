//
//  CMTime.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/18/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import Foundation

import Foundation
import AVKit
extension CMTime {
    var durationText:String {
        let totalSeconds = CMTimeGetSeconds(self)
        if totalSeconds.isNaN {
            return "00:00"
        }
        
        let hours = Int(totalSeconds / 3600)
        let minutes = Int((totalSeconds.truncatingRemainder(dividingBy: 3600)) / 60)
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
}
