//
//  PeopleCell.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import UIKit

class PeopleCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PeopleCell"
    
    @IBOutlet weak var mainView: UIView!{
        didSet{
            mainView.backgroundColor = .lightGray
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            nameLabel.textColor = .white
        }
    }
    
    func updateUI(_ model: PersonModel){
        nameLabel.text = model.name
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
