//
//  MainViewController.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import UIKit
import CoreLocation


fileprivate enum AppState {
    case normal
    case chooseLocation
}

class MainViewController: UIViewController {
    
    lazy var mainSuperView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var mapParentView: UIView = {
       let view = UIView()
        return view
    }()
    
    lazy var centerMarkerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_marker"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.isHidden = true
        button.addTarget(self, action: #selector(clickMarkerButton), for: .touchUpInside)
        return button
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
        button.addShadow(color: .blue)
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
        button.addShadow(color: .blue)
        button.isHidden = true
        return button
    }()
    
    lazy var cancelButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(named: "ic_close_black"), for: .normal)
        button.layer.cornerRadius = 10
        button.isHidden = true
        button.addShadow()
        button.addTarget(self, action: #selector(clickCencelButton), for: .touchUpInside)
        return button
    }()
    
    lazy var peopleCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: PeopleCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: PeopleCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.semanticContentAttribute = .forceLeftToRight
        collectionView.backgroundColor = .black
        return collectionView
    }()
    

    
    private var peopleArray: [PeopleCellModel] = []
    private var appState: AppState = .normal
    private var currentPosition: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    let viewModel = MainViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAllLayouts()
        loadData()
    }
    
    
    private func createAllLayouts(){
        setupMainSuperView()
        setupFooterView()
        setupMapParentView()
        setupMapView()
        setupCenterMarker()
        setupAddLocationButton()
        setupEmptyLabel()
        setupNextButton()
        setupCancelButton()
        setupPeopleCollectionView()
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
            self.peopleCollectionView.reloadData()
            self.peopleCollectionView.layoutIfNeeded()
        }
    }

}

private extension MainViewController {
    @objc
    func clickAddLocation() {
        
        if LocationService.shared.isEnableLocation() {
            appState = .chooseLocation

            DispatchQueue.mainThread { [weak self] in
                guard let self = self else {return}
                self.addLocationButton.isHidden = true
                self.peopleCollectionView.isHidden = true
                self.emptyLabel.isHidden = true
                
                self.nextButton.isHidden = false
                self.cancelButton.isHidden = false
                self.centerMarkerButton.isHidden = false
            }
        }else {
            LocationService.shared.gotoEnableLocationSetting("Please Enable your Location")
        }

    }
    
    @objc
    func clickNextButton() {
        DispatchQueue.mainThread { [weak self] in
            guard let self = self else {return}
            let vc = PeopleListVC(nibName: PeopleListVC.nibName, bundle: nil)
//            vc.modalTransitionStyle = .coverVertical
//            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc
    func clickMarkerButton() {
        clickNextButton()
    }
    
    @objc
    func clickCencelButton() {
        appState = .normal
        DispatchQueue.mainThread { [weak self] in
            guard let self = self else {return}
            self.addLocationButton.isHidden = false
            self.peopleCollectionView.isHidden = false
            self.emptyLabel.isHidden = false

            self.nextButton.isHidden = true
            self.cancelButton.isHidden = true
            self.centerMarkerButton.isHidden = true
        }
    }
    
    func clickOnCollectionViewCell(indexPath: IndexPath) {
        resetItemSelection()
        peopleArray[indexPath.row].select()
        reloadData()
    }
    
    func resetItemSelection() {
        for index in 0..<peopleArray.count {
            peopleArray[index].unSelect()
        }
    }
}

//MARK: - CollectionView Delegate & DataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeopleCell.reuseIdentifier,
                                                         for: indexPath) as? PeopleCell {
            if peopleArray.count > 0 && indexPath.row < peopleArray.count {
                cell.updateUI(peopleArray[indexPath.row])
            }
            return cell
        }
        else {
            Log("~ PeopleCell withIdentifier cell_id Failure")
            return PeopleCell()
        }
    }
    
    //Set dynamic size for width
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cell: PeopleCell = Bundle.main.loadNibNamed(PeopleCell.nibName,
                                                              owner: self,
                                                              options: nil)?.first as? PeopleCell else { return CGSize.zero }
        cell.updateUI(peopleArray[indexPath.row])
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickOnCollectionViewCell(indexPath: indexPath)
    }
    
}

//MARK: - ScrollView Delegate
extension MainViewController: UIScrollViewDelegate {
}


extension MainViewController: ChildToParentMapProtocol {
    func mapDidChange() {
        
    }
    
    func mapCameraIdle(_ position: CLLocationCoordinate2D) {
        if appState == .chooseLocation {
            currentPosition = position
        }
    }
    
    func mapWillMove() {
        
    }
    
}
