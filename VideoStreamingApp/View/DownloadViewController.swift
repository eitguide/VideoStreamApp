//
//  DownloadViewController.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/17/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import UIKit
import RxSwift

final class DownloadViewController: UIViewController {

    static let cellIdentifier = "DownloadCell"
    
    let vm: DownloadViewModel
    let bag = DisposeBag()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    

    init(vm: DownloadViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        setupView()
        bind()
        vm.loadData()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DownloadCell.self, forCellWithReuseIdentifier: DownloadViewController.cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        localize()
    }

    private func  localize() {
        title = "Offline vides"
        tabBarController?.title = title
    }
    
    func bind() {
        vm.streams.asObservable().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] streams in
                self?.collectionView.reloadData()
            }).disposed(by: bag)
    }
}

extension DownloadViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.streams.value.count
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.width - 40 - 10) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DownloadViewController.cellIdentifier, for: indexPath) as! DownloadCell
        cell.stream = vm.streams.value[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stream = vm.streams.value[indexPath.row]
        print(stream.offlineUrl)
        let playVM = PlayViewModel(streams: vm.streams.value, index: indexPath.row)
        let playVC = PlayViewController(vm: playVM, isPlayOffline: true)
        navigationController?.pushViewController(playVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
