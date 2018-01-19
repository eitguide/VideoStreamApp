//
//  Spout.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/16/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import Foundation
import Moya

enum Spout {
    case loadStream
}


extension Spout: TargetType {
    var baseURL: URL {
        return URL(string: "https://s3-ap-southeast-1.amazonaws.com")!
    }
    
    var path: String {
        switch self {
        case .loadStream:
            return "/spout-output/data.json"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
       return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
