//
//  PeopleCell.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import UIKit

class PeopleCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PeopleCell"
    static let nibName = "PeopleCell"
    
    @IBOutlet weak var mainView: UIView!{
        didSet{
            mainView.backgroundColor = .lightGray
            mainView.layer.cornerRadius = 10
            mainView.layer.borderColor = UIColor.white.cgColor
            mainView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            nameLabel.textColor = .white
        }
    }
    
    func updateUI(_ model: CellViewModel){
        nameLabel.text = model.person.fullName()
        if model.isSelected {
            mainView.backgroundColor = .systemBlue
        }else {
            mainView.backgroundColor = .lightGray
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
