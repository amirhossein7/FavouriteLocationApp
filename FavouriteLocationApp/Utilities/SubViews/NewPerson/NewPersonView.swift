//
//  NewPersonView.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import UIKit

class NewPersonView: UIView {

    @IBOutlet var view: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.text = "New Person"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        }
    }
    
    @IBOutlet weak var firstNameLabel: UILabel!{
        didSet {
            firstNameLabel.text = "First Name"
        }
    }
    
    @IBOutlet weak var firstNameTextField: UITextField!{
        didSet {
            firstNameTextField.font = UIFont.boldSystemFont(ofSize: 20)
            firstNameTextField.textAlignment = .center
            firstNameTextField.layer.cornerRadius = 10
            firstNameTextField.layer.borderColor = UIColor.black.cgColor
            firstNameTextField.layer.borderWidth = 2
            firstNameTextField.clipsToBounds = true
            firstNameTextField.layoutIfNeeded()
        }
    }
    
    @IBOutlet weak var lastNameLabel: UILabel!{
        didSet {
            lastNameLabel.text = "Surname"
        }
    }
    
    @IBOutlet weak var lastNameTextField: UITextField!{
        didSet {
            lastNameTextField.font = UIFont.boldSystemFont(ofSize: 20)
            lastNameTextField.textAlignment = .center
            lastNameTextField.layer.cornerRadius = 10
            lastNameTextField.layer.borderColor = UIColor.black.cgColor
            lastNameTextField.layer.borderWidth = 2
            lastNameTextField.clipsToBounds = true
            lastNameTextField.layoutIfNeeded()
        }
    }
    
    @IBOutlet weak var confirmButton: UIButton! {
        didSet{
            confirmButton.layer.cornerRadius = 10
            confirmButton.setTitle("Confirm", for: .normal)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    func requirement(){
        self.backgroundColor = .clear
        self.view.backgroundColor = .white
    }

}
