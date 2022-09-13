//
//  MainViewController.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    lazy var mainSuperView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var footerView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    lazy var addLocationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(clickAddLocation), for: .touchUpInside)
        return button
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Empty"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.isHidden = true
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(clickNextButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var peopleCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        return collectionView
    }()
    
    
    private var peopleArray: [PersonModel] = [
        PersonModel(name: "amir", locations: [LocationModel(latitude: -33.9, longitude: 151.20)]),
        PersonModel(name: "mahsa", locations: [LocationModel(latitude: -33.9, longitude: 151.20)]),
        PersonModel(name: "amir", locations: [LocationModel(latitude: -33.9, longitude: 151.20)]),
        PersonModel(name: "amir", locations: [LocationModel(latitude: -33.9, longitude: 151.20)]),
        PersonModel(name: "amir", locations: [LocationModel(latitude: -33.9, longitude: 151.20)]),
        PersonModel(name: "amir", locations: [LocationModel(latitude: -33.9, longitude: 151.20)]),
        PersonModel(name: "amir", locations: [LocationModel(latitude: -33.9, longitude: 151.20)]),
        PersonModel(name: "amir", locations: [LocationModel(latitude: -33.9, longitude: 151.20)]),
        PersonModel(name: "amir", locations: [LocationModel(latitude: -33.9, longitude: 151.20)]),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        peopleCollectionView.register(UINib(nibName: PeopleCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: PeopleCell.reuseIdentifier)
        peopleCollectionView.showsHorizontalScrollIndicator = false
        peopleCollectionView.isUserInteractionEnabled = true
        peopleCollectionView.semanticContentAttribute = .forceLeftToRight
        
        createAllLayouts()
    }
    
    
    private func createAllLayouts(){
        setupMainSuperView()
        setupFooterView()
        setupMapView()
        setupAddLocationButton()
        setupEmptyLabel()
        setupNextButton()
        setupPeopleCollectionView()
    }


}

private extension MainViewController {
    @objc
    func clickAddLocation() {
        nextButton.isHidden = false
        emptyLabel.isHidden = true
    }
    
    @objc
    func clickNextButton() {
        nextButton.isHidden = true
        emptyLabel.isHidden = false
    }
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeopleCell.reuseIdentifier, for: indexPath) as? PeopleCell {
            if peopleArray.count > 0 && indexPath.row < peopleArray.count {
                cell.updateUI(peopleArray[indexPath.row])
            }
            return cell
        }
        else {
            Log("PeopleCell withIdentifier cell_id Failure")
            return PeopleCell()
        }
    }
    
}

extension MainViewController: ChildToParentMapProtocol {
    func mapDidChange() {
        
    }
    
    func mapCameraIdle(_ position: CLLocationCoordinate2D) {
        
    }
    
    func mapWillMove() {
        
    }
    
}
