//
//  DownloadViewModel.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/19/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import Foundation
import RxSwift

class DownloadViewModel {
    let streams = Variable<[Stream]>([])
    
    func loadData() {
        var data = [Stream]()
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            if fileURLs.count > 0 {
                for url in fileURLs {
                    if url.lastPathComponent.contains("mp4") {
                        let stream = Stream()
                        stream.offlineUrl = url.absoluteString
                        data.append(stream)
                    }
                }
                
                if data.count > 0 {
                    streams.value = data
                }
            }
        } catch {
           return
        }
        
    }
}
