//
//  PeopleListVC.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import UIKit

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
    
    private var peopleArray: [PeopleCellModel] = []
    let viewModel = PeopleListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView()
        loadData()
        
    }
    
    
    private func registerTableView() {
        peopleTableView.register(UINib(nibName: CellPeopleList.nibName, bundle: nil), forCellReuseIdentifier: CellPeopleList.reuseableIdentifier)
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
    }

    private func loadData(){
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {return}
            self.peopleArray = self.viewModel.getAllItems()
            self.reloadData()
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
        
    }
    
    @objc
    func clickNextButton() {
        
    }
    
    func clickOnTableViewCell(_ indexPath: IndexPath) {
        peopleArray[indexPath.row].select()
        reloadData()
    }
}



extension PeopleListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellPeopleList.reuseableIdentifier, for: indexPath) as? CellPeopleList {
            if peopleArray.count > 0 && indexPath.row < peopleArray.count {
                cell.updateUI(peopleArray[indexPath.row])
            }
            
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
