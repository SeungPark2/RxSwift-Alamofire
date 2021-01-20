//
//  ViewController.swift
//  Rxswift+Alamofire
//
//  Created by 박승태 on 2021/01/19.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var moneyExchangeTableView: UITableView!
    var moneyExchangeList = BehaviorRelay(value: [MoneyExchange]())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.shared.fetchData()
            .subscribe(onNext: { data in
                
                self.moneyExchangeList.accept(data)
            })
            .disposed(by: disposeBag)
        
        moneyExchangeList
            .bind(to: self.moneyExchangeTableView.rx.items(cellIdentifier: "moneyExchangeCell",
                                                           cellType: MoneyCell.self)) { (row, item, cell) in
                         
                cell.date.text = item.date
                cell.name.text = item.name
                cell.rate.text = "\(item.rate)"
                cell.timestamp.text = item.timestamp
            }
            .disposed(by: self.disposeBag)
        
        
    }
}

