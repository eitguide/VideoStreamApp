//
//  StreamViewModel.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/16/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import Foundation
import RxSwift
import Gloss

final class StreamViewModel {
    
    let errorPublishSubject = PublishSubject<Void>()
    var streams = Variable<[Stream]>([])
    
    func loadStream() {
        SpoutAPIProvider.shared.request(Spout.loadStream) { [weak self] result in
            guard let me  = self else { return }
            switch result {
            case .success(let result):
                if let repoStream = [Stream].from(data: result.data) {
                    self?.streams.value = repoStream
                }
            case .failure(let err):
                me.errorPublishSubject.onNext(())
            }
        }
    }
}
