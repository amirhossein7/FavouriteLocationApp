//
//  CellPeopleList.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import UIKit

class CellPeopleList: UITableViewCell {
    
    static let nibName: String = "CellPeopleList"
    static let reuseableIdentifier: String = "CellPeopleList"

    @IBOutlet weak var mainView: UIView!{
        didSet {
            mainView.layer.cornerRadius = 10
            mainView.layer.borderColor = UIColor.black.cgColor
            mainView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var checkImageView: UIImageView!{
        didSet {
            checkImageView.layer.cornerRadius = 20
            checkImageView.backgroundColor = .gray
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet {
            nameLabel.textAlignment = .center
            nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
            
        }
    }
    
    
    func updateUI(_ model: PeopleCellModel) {
        nameLabel.text = model.person.fullName()
        if model.isSelected {
            checkImageView.backgroundColor = .green
        }else {
            checkImageView.backgroundColor = .gray
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
