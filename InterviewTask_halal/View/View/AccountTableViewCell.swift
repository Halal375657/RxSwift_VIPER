//
//  AccountTableViewCell.swift
//  RxSwiftDemo
//
//  Created by iOS on 12/9/22.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    var viewModel: Account? {
        didSet {
            fillUI()
        }
    }
    
    //MARK: Static Properties
    
    public static var resuseIdentifier: String {
            return String(describing: "reuse_identifier")
    }
    
    // MARK: Properties
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var currentBalanceLabel: UILabel!
    @IBOutlet weak var availableBalanceLabel: UILabel!

    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    // MARK: - Private
    
    fileprivate func styleUI() {
        
    }
    
    fileprivate func fillUI() {
        guard let viewModel = viewModel else {
            return
        }

        accountLabel.text = "\(viewModel.accountLabel ?? "")"
        accountNumberLabel.text = "\(viewModel.accountNumber ?? "")"
        currentBalanceLabel.text = "$\(viewModel.currentBalance ?? "")"
        availableBalanceLabel.text = "$\(viewModel.availableBalance ?? "")"
    }
}
