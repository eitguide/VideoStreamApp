//
//  SpoutAPIProvider.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/16/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import Foundation
import Moya

final class SpoutAPIProvider: MoyaProvider<Spout> {
    static let shared = SpoutAPIProvider()
}
