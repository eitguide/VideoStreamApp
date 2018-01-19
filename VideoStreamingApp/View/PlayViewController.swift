//
//  PlayViewController.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/16/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import UIKit
import AVKit
import RxSwift

final class PlayViewController: UIViewController {

    private let avPlayer: AVPlayer = AVPlayer()
    private var playerLayer: AVPlayerLayer?
    private let loadingIndicator = UIActivityIndicatorView()
    
    private let controlContainerView = UIView()
    
    private let currentTimeLabel = UILabel()
    private let totalTimeLabel = UILabel()
    private let slider = UISlider()
    private let playButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let backButton = UIButton(type: .system)
    
    private let closeButton = UIButton(type: .system)
    
    let bag = DisposeBag()
    
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    let vm: PlayViewModel
    
    init(vm: PlayViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayer()
        visualize()
        localize()
        bind()
        
        avPlayer.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        let interval = CMTimeMake(1, 1)
        avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] (cmTime) in
            self?.currentTimeLabel.text = cmTime.durationText
            let second = CMTimeGetSeconds(cmTime)
            
            guard let duration = self?.avPlayer.currentItem?.duration else { return }
            let durationSecond = CMTimeGetSeconds(duration)
            let value = second / durationSecond
            self?.slider.value = Float(value)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            guard let duration = avPlayer.currentItem?.duration else { return }
            totalTimeLabel.text = duration.durationText
        }
    }
    
    private func setupLayer() {
        playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer?.frame = view.bounds
        view.layer.addSublayer(playerLayer!)
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlContainerView.layer.addSublayer(gradientLayer)
    }
    private func setupView() {
        
        view.addSubview(controlContainerView)
        controlContainerView.layer.zPosition = 10
        controlContainerView.addSubview(currentTimeLabel)
        controlContainerView.addSubview(totalTimeLabel)
        controlContainerView.addSubview(slider)
        controlContainerView.addSubview(playButton)
        controlContainerView.addSubview(backButton)
        controlContainerView.addSubview(nextButton)
        controlContainerView.addSubview(closeButton)
        
        controlContainerView.translatesAutoresizingMaskIntoConstraints = false
        currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        totalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        // layout child view
        
        NSLayoutConstraint.activate([
            controlContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controlContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controlContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            controlContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            currentTimeLabel.leadingAnchor.constraint(equalTo: controlContainerView.leadingAnchor, constant: 20),
            currentTimeLabel.bottomAnchor.constraint(equalTo: controlContainerView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            totalTimeLabel.trailingAnchor.constraint(equalTo: controlContainerView.trailingAnchor, constant: -20),
            totalTimeLabel.widthAnchor.constraint(equalTo: currentTimeLabel.widthAnchor),
            totalTimeLabel.bottomAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: currentTimeLabel.trailingAnchor, constant: 10),
            slider.trailingAnchor.constraint(equalTo: totalTimeLabel.leadingAnchor, constant: -10),
            slider.centerYAnchor.constraint(equalTo: currentTimeLabel.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: controlContainerView.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: controlContainerView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 60),
            playButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: controlContainerView.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: controlContainerView.leadingAnchor, constant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            nextButton.centerYAnchor.constraint(equalTo: controlContainerView.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: controlContainerView.trailingAnchor, constant: -50),
            nextButton.widthAnchor.constraint(equalToConstant: 60),
            nextButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: controlContainerView.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: controlContainerView.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            ])
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
       
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func visualize() {
        
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        
        currentTimeLabel.textColor = .white
        totalTimeLabel.textColor = .white
        
        playButton.setImage(#imageLiteral(resourceName: "play_stream"), for: .normal)
        playButton.tintColor = UIColor(hex: 0xecf0f1)
        
        nextButton.setImage(#imageLiteral(resourceName: "ic_next"), for: .normal)
        backButton.setImage(#imageLiteral(resourceName: "ic_back"), for: .normal)
        nextButton.tintColor = UIColor(hex: 0xecf0f1)
        backButton.tintColor = UIColor(hex: 0xecf0f1)
        closeButton.tintColor = UIColor(hex: 0xecf0f1)
        
        closeButton.setImage(#imageLiteral(resourceName: "ic_close"), for: .normal)
        closeButton.tintColor = UIColor(hex: 0xecf0f1)
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(controlContainerDidTap(_:))))
    }
    
    @objc func controlContainerDidTap(_ sender: UITapGestureRecognizer) {
        vm.changeHiddenState()
    }
    
    private func localize() {
        currentTimeLabel.text = "00:00"
        totalTimeLabel.text = "00:00"
    }
    
    private func bind() {
        
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: bag)
        
        
        playButton.rx.tap.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let me = self else { return }
                if me.avPlayer.isPlaying {
                    me.avPlayer.pause()
                } else {
                    me.avPlayer.play()
                }
                
                me.vm.changePlayState(isPlaying: !me.avPlayer.isPlaying)
            }).disposed(by: bag)
        
        
        vm.currentStream.asObservable().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                guard let me = self, let stream = value else { return }
                
                if me.avPlayer.isPlaying {
                    me.avPlayer.pause()
                }
                
                let url = URL(string: stream.streamUrl ?? "")
                let playerItem = AVPlayerItem(url: url!)
                
                NotificationCenter.default.addObserver(me, selector: #selector(me.itemDidPlayToEndTime), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
                
                me.avPlayer.replaceCurrentItem(with: playerItem)
                
                me.playButton.setImage(#imageLiteral(resourceName: "play_stream"), for: .normal)
            }).disposed(by: bag)
        
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.vm.handleNext()
            }).disposed(by: bag)
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.vm.handleBack()
            }).disposed(by: bag)
        
        slider.rx.value.subscribe(onNext: { [weak self] (value: Float) in
            guard let me = self else { return }
            guard let duration = me.avPlayer.currentItem?.duration else { return }
            let totalSecond = CMTimeGetSeconds(duration)
            let value = totalSecond * Float64(value)
            
            let cmTimer = CMTime(seconds: value, preferredTimescale: CMTimeScale(1.0))
            self?.avPlayer.seek(to: cmTimer, completionHandler: { _ in
                //
            })
           
        }).disposed(by: bag)
        
        vm.hideControlContainView.asObservable().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] hidden in
                self?.animateHideControlContainerView(hide: hidden)
            }).disposed(by: bag)
        
        vm.playStatePublishSubject.asObservable().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] isPlaying in
                guard let me = self else { return }
                me.playButton.setImage(isPlaying ? #imageLiteral(resourceName: "play_stream") : #imageLiteral(resourceName: "pause_stream"), for: .normal)
                
            }).disposed(by: bag)
        
        
        vm.endListPublishSubject.asObservable().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                let alertVC = UIAlertController(title: "Message", message: "End list stream", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (ac) in
                    
                })
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (ac) in
                    self?.navigationController?.popViewController(animated: true)
                })
                
                alertVC.addAction(cancelAction)
                alertVC.addAction(okAction)
                self?.present(alertVC, animated: true, completion: nil)
                
            }).disposed(by: bag)
    }
    
    @objc func itemDidPlayToEndTime() {
        vm.handleNext()
    }
    
    
    private func animateHideControlContainerView(hide: Bool) {
        if hide == true {
            controlContainerView.alpha = 1
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.controlContainerView.alpha = 0
            }, completion: nil)
        } else {
            controlContainerView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
                self?.controlContainerView.alpha = 1
            }, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
}

extension PlayViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("NghiaNV-audioPlayerDidFinishPlaying-\(flag)")
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
         print("NghiaNV-audioPlayerDecodeErrorDidOccur-\(error)")
    }
}
