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
    
    @IBOutlet weak var moneyExchangeTableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    var moneyExchangeList = BehaviorRelay(value: [MoneyExchange]())
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.shared.fetchData()
            .subscribe(onNext: { data in
                
                self.moneyExchangeList.accept(data)
            })
            .disposed(by: disposeBag)
        
        moneyExchangeList
            .map { $0.count != 0 }
            .bind(to: noDataView.rx.isHidden )
            .disposed(by: disposeBag)
        
        moneyExchangeTableView.tableFooterView = UIView()
        moneyExchangeList
            .bind(to: self.moneyExchangeTableView.rx.items(cellIdentifier: "moneyExchangeCell",
                                                           cellType: MoneyCell.self)) { (row, item, cell) in

                cell.dateLabel.text = item.date
                cell.nameLabel.text = item.name
                cell.rateLabel.text = "\(item.rate)"
                cell.timeStampLabel.text = item.timestamp
            }
            .disposed(by: disposeBag)
        
        moneyExchangeTableView.rx.itemSelected
            .bind { index  in

                print(self.moneyExchangeList.value[index.row])
            }
            .disposed(by: disposeBag)
            
    }
}

