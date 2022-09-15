//
//  TransactionDetailTableCell.swift
//  RxSwiftDemo
//
//  Created by iOS on 13/9/22.
//

import UIKit

class TransactionDetailTableCell: UITableViewCell {
    
    var viewModel: Transaction? {
        didSet {
            fillUI()
        }
    }
    
    //MARK: Static Properties
    public static var reuseIdentifier: String {
            return String(describing: self)
    }
    
    //MARK: - Properties
    private let amountLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let descriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        contentView.addSubview(amountLabel)
        contentView.addSubview(descriptionLabel)
        styleUI()
        contentView.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    fileprivate func styleUI() {
        fillConstraints()
    }
        
    fileprivate func fillConstraints() {
        
        [
            amountLabel,
            descriptionLabel
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [
            amountLabel.heightAnchor.constraint(equalToConstant: 20),
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            amountLabel.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 8),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            contentView.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10)
            
        ].forEach { nslayout in
            nslayout.isActive = true
        }
    }
    
    fileprivate func fillUI() {
        guard let viewModel = viewModel else {
            return
        }

        let formatted = String(format: "%.2f", Float(viewModel.amount ?? "0") ?? 0)
        amountLabel.text = "- $\(formatted)"
        descriptionLabel.text = viewModel.transactionDescription
    }

}
