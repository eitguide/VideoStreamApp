//
//  DownloadManager.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/19/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import Foundation
import Alamofire

class DownloadManager {
    static let shared = DownloadManager()
    let destination: DownloadRequest.DownloadFileDestination = { _, _ in
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("video.mp4")
        
        return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
    }
    
    private init() {
        
    }
    
    func downloadFile(url: URL, completeHandler: @escaping ((Bool) -> ())) {
        Alamofire.download(url, to: destination).response { (response) in
            if response.error != nil {
                completeHandler(false)
            } else {
                completeHandler(true)
            }
        }
    }
    
    func downloadImage(urlImage: URL, completeHandler: (()->())) {
        Alamofire.download(urlImage).responseData { (responseData) in
            if let data = responseData.result.value {
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let desFile = documentsURL.appendingPathComponent("nghia.png")
                try! data.write(to: desFile)
            }
        }
    }
}
