//
//  AVPlayer.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/18/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import Foundation
import AVKit
extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
