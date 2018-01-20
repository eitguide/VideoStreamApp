//
//  ViewController.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/16/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import Alamofire
import Toaster

struct StreamSection: SectionModelType {
    var items: [Stream]
    
    typealias Item = Stream
    
    init(items: [Item]) {
        self.items = items
    }
    
    init(original: StreamSection, items: [Item]) {
        self = original
        self.items = items
    }
}

class ViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let bag = DisposeBag()
    
    private let nghiaNV = Variable<[Stream]>([])
    private let vm: StreamViewModel
    private static let cellIdentifier = "StreamcCell"
    
    let dataSource = RxTableViewSectionedReloadDataSource<StreamSection>(configureCell: { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellIdentifier, for: indexPath) as! StreamCell
        cell.stream = item
        cell.tag = indexPath.row
        return cell
    })
    
 
    init(vm: StreamViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        tableView.register(StreamCell.self, forCellReuseIdentifier: ViewController.cellIdentifier)
        tableView.rowHeight = 200
        tableView.separatorStyle = .none
        bind()
        
        vm.loadStream()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        localize()
    }

    private func setupView() {
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    

    private func localize() {
        title = "Streams"
        tabBarController?.title = title
    }
    
    private func bind() {
        vm.streams.asObservable().map({ streams -> [StreamSection] in
            return [StreamSection(items: streams)]
        }).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: bag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let me = self else { return }
            let playVM = PlayViewModel(streams: me.vm.streams.value, index: indexPath.row)
            let playVC = PlayViewController(vm: playVM)
            self?.navigationController?.pushViewController(playVC, animated: true)
        }).disposed(by: bag)
        
        tableView.rx.willDisplayCell.subscribe(onNext: { [weak self] cell, indexPath in
            guard let me = self else { return }
            guard let streamCell = cell as? StreamCell else { return }
            streamCell.delegate = me
        }).disposed(by: bag)
        
        vm.errorPublishSubject.observeOn(MainScheduler.instance).subscribe(onNext: {
            Toast.init(text: "Error load stream", delay: Delay.long, duration: Delay.long).show()
        }).disposed(by: bag)
    }
}

extension ViewController: DownloadStreamDidTapDelegate {
    func downloadDidTap(index: Int) {
        print("NghiaNV-\(index)")
        let stream = vm.streams.value[index]
//        DownloadManager.shared.downloadImage(urlImage: URL(string: stream.backgroundImageUrl!)!) {
//
//        }
        
//        DownloadManager.shared.downloadFile(url: URL(string: stream.backgroundImageUrl!)!) { (value) in
//            print("NghiaNV-\(value)")
//        }
        
        
      
        tabBarController?.selectedIndex = 1
    }
}


