//
//  PeopleListVC.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import UIKit
import CoreLocation

class PeopleListVC: UIViewController {
    
    static let nibName: String = "PeopleListVC"
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 10
            nextButton.backgroundColor = .systemBlue
            nextButton.setTitle("Next", for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            nextButton.addShadow()
            nextButton.addTarget(self, action: #selector(clickNextButton), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var peopleTableView: UITableView!{
        didSet {
            peopleTableView.backgroundColor = .clear
            peopleTableView.separatorStyle = .none
        }
    }
    
    @IBOutlet weak var addPersonButton: UIButton! {
        didSet {
            addPersonButton.layer.cornerRadius = 25
            addPersonButton.backgroundColor = .systemBlue
            addPersonButton.setTitle("+", for: .normal)
            addPersonButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            addPersonButton.addShadow(color: .blue)
            addPersonButton.addTarget(self, action: #selector(clickAddPersonButton), for: .touchUpInside)
        }
    }
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.alpha = 0.5
        view.backgroundColor = .black
        view.addTapGesture(tapNumber: 1, target: self, action: #selector(dismissNewPersonSubView))
        return view
    }()
    
    private lazy var newPersonView: NewPersonView = {
        let view = NewPersonView()
        view.view.layer.cornerRadius = 10
        view.confirmButton.addTarget(self, action: #selector(clickConfirmButton), for: .touchUpInside)
        return view
    }()
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        self.viewModel.resetAllSelection()
        super.init(nibName: PeopleListVC.nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewWhenKeyboardUp()
        registerTableView()
        reloadData()
    }
    
    private func registerTableView() {
        peopleTableView.register(UINib(nibName: CellPeopleList.nibName, bundle: nil), forCellReuseIdentifier: CellPeopleList.reuseableIdentifier)
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
    }

    private func loadData(){
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {return}
            self.viewModel.reloadData {
                self.reloadData()
            }
        }

    }

    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.peopleTableView.reloadData()
            self.peopleTableView.layoutIfNeeded()
        }
    }
}


private extension PeopleListVC {
    
    @objc
    func clickAddPersonButton() {
    
        DispatchQueue.mainThread { [weak self] in
            guard let self = self else {return}
            self.displayShadowView()
            self.displayNewPersonSubView()
        }
    }
    
    func displayShadowView() {
        view.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        [
            shadowView.topAnchor.constraint(equalTo: view.topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach{$0.isActive = true}
    }
    
    func displayNewPersonSubView() {
        view.addSubview(self.newPersonView)
        newPersonView.translatesAutoresizingMaskIntoConstraints = false
        [
            newPersonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newPersonView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            newPersonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            newPersonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            newPersonView.heightAnchor.constraint(equalToConstant: 360)
        ].forEach{$0.isActive = true}
    }
    
    @objc
    func clickConfirmButton() {
        guard let firstName = self.newPersonView.firstNameTextField.text , firstName != "" else {
            self.newPersonView.errorInFirstName()
            return
        }
        guard let lastName = self.newPersonView.lastNameTextField.text , lastName != ""  else {
            self.newPersonView.errorInLastName()
            return
        }
        self.viewModel.createPerson(firstName: firstName, lastName: lastName)
        self.dismissNewPersonSubView()
        self.loadData()
        NotificationCenter.default.post(name: .reloadDataInMainVC, object: nil)
    }
    
    @objc
    func dismissNewPersonSubView() {
        DispatchQueue.mainThread { [weak self] in
            guard let self = self else {return}
            self.shadowView.removeFromSuperview()
            self.newPersonView.resetTextFileds()
            self.newPersonView.removeFromSuperview()
        }
    }

    
    @objc
    func clickNextButton() {
        DispatchQueue.backgroundToMain { [weak self] in
            guard let self = self else {return}
            var personIdArray: [Int] = []
            let chosenLocation = self.viewModel.chosenLocation

            self.viewModel.selectedPeople.forEach { item in
                personIdArray.append(item.person.id)
            }
            
            self.viewModel.addAddress(personsID: personIdArray, lat: Double(chosenLocation.latitude), long: Double(chosenLocation.longitude))
        } completion: { [weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: .reloadDataInMainVC, object: nil)
            }
        }



    }
    
    func clickOnTableViewCell(_ indexPath: IndexPath) {
        viewModel.selectPeople(at: indexPath)
        reloadData()
    }
}


private extension PeopleListVC {
    
    func configureViewWhenKeyboardUp(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
}


extension PeopleListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellPeopleList.reuseableIdentifier, for: indexPath) as? CellPeopleList {
            
            let model = viewModel.getCellViewModel(at: indexPath)
            cell.updateUI(model)
            
            return cell
        }else {
            Log("~ CellPeopleList withIdentifier cell_id Failure")
            return CellPeopleList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clickOnTableViewCell(indexPath)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        // color is color press
        if let cell  = tableView.cellForRow(at: indexPath){
            cell.contentView.backgroundColor = UIColor(hex:"FFFFFF")
        }
        
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        // color is color UnPress(first press then few drag)
        if let cell  = tableView.cellForRow(at: indexPath){
            cell.contentView.backgroundColor = UIColor(hex:"FFFFFF")
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // color is color ContentView in Cell
        if let cell  = tableView.cellForRow(at: indexPath){
            cell.contentView.backgroundColor = UIColor(hex:"FFFFFF")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
