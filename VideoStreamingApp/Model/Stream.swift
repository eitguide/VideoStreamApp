//
//  Stream.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/16/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import Foundation
import Gloss

class Stream: JSONDecodable {
    var id: Int?
    var name: String?
    var backgroundImageUrl: String?
    var streamUrl: String?
    var offlineUrl: String?

    required init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.backgroundImageUrl = "background_image_url" <~~ json
        self.streamUrl =  "stream_url" <~~ json
        self.offlineUrl =  "offline_url" <~~ json
    }
}

