//
//  CustomPopup.swift
//  Rxswift+Alamofire
//
//  Created by 박승태 on 2021/01/23.
//

import UIKit

class CustomePopup: UIView {
    
    var moneyExchange: MoneyExchange?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setInit()
    }
    
    func setInit() {
                
        let view = Bundle.main.loadNibNamed("CustomPopup",
                                            owner: self,
                                            options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        self.dateLabel.text = moneyExchange?.date
        self.nameLabel.text = moneyExchange?.name
        self.rateLabel.text = "\(moneyExchange?.rate ?? 0.0)"
        self.timeStampLabel.text = moneyExchange?.timestamp
    }
    
    @IBAction func remove(_ sender: UIButton) {
        
        self.removeFromSuperview()
    }
}
