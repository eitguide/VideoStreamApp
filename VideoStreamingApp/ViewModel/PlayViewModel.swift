//
//  PlayViewModel.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/18/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import Foundation
import RxSwift

class PlayViewModel {
    
    private let streams: [Stream]
    let currentStream = Variable<Stream?>(nil)
    var currentIndex: Int
    
    let hideControlContainView = Variable<Bool>(false)
    let playStatePublishSubject = PublishSubject<Bool>()
    let endListPublishSubject = PublishSubject<Void>()
    
    init(streams: [Stream], index: Int) {
        self.streams = streams
        self.currentIndex = index
        currentStream.value = self.streams[self.currentIndex]
    }
    
    func changeHiddenState() {
        hideControlContainView.value = !hideControlContainView.value
    }
    
    func changePlayState(isPlaying: Bool) {
        playStatePublishSubject.onNext(isPlaying)
    }
    
    func handleNext() {
        if currentIndex >= streams.count - 1 {
            endListPublishSubject.onNext(())

        } else {
            currentIndex = currentIndex + 1
            currentStream.value = streams[currentIndex]
        }
    }
    
    func handleBack() {
        if currentIndex <= 0 {
            endListPublishSubject.onNext(())
        } else {
            currentIndex = currentIndex - 1
            currentStream.value = streams[currentIndex]
        }
    }
}
