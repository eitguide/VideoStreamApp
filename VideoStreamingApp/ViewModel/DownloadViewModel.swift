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
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
    }
}
