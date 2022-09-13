//
//  MainVC+Extensions.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import UIKit
import CoreLocation

extension MainViewController {
    
    // MARK: - setup main super view
    func setupMainSuperView() {
        view.addSubview(mainSuperView)
        mainSuperView.translatesAutoresizingMaskIntoConstraints = false
        [
            mainSuperView.topAnchor.constraint(equalTo: view.topAnchor),
            mainSuperView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainSuperView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainSuperView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach{$0.isActive = true}
    }
    // MARK: - setup footer
    func setupFooterView() {
        mainSuperView.addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        [
            footerView.bottomAnchor.constraint(equalTo: mainSuperView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: mainSuperView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: mainSuperView.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 100)
        ].forEach{$0.isActive = true}
    }
    // MARK: - setup map
    func setupMapView() {
        let defaultLocation = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        let child = GoogleMapViewController(self, defaultCoordinate: defaultLocation)
        add(child: child, in: mainSuperView)
        addMapConstraints(child)
    }
    func addMapConstraints(_ child: UIViewController){
        child.view.translatesAutoresizingMaskIntoConstraints = false
        [
            child.view.topAnchor.constraint(equalTo: mainSuperView.topAnchor),
            child.view.leadingAnchor.constraint(equalTo: mainSuperView.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: mainSuperView.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: footerView.topAnchor)
        ].forEach{$0.isActive = true}
    }
    // MARK: - setup add location button
    func setupAddLocationButton() {
        mainSuperView.addSubview(addLocationButton)
        addLocationButton.translatesAutoresizingMaskIntoConstraints = false
        [
            addLocationButton.trailingAnchor.constraint(equalTo: mainSuperView.trailingAnchor, constant: -32),
            addLocationButton.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -32),
            addLocationButton.heightAnchor.constraint(equalToConstant: 50),
            addLocationButton.widthAnchor.constraint(equalToConstant: 50)
        ].forEach{$0.isActive = true}
        addLocationButton.layer.cornerRadius = 25
    }
    // MARK: - setup empty label
    func setupEmptyLabel() {
        footerView.addSubview(emptyLabel)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        [
            emptyLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ].forEach{$0.isActive = true}
    }
    // MARK: - setup next button
    func setupNextButton() {
        footerView.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        [
            nextButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 250)
        ].forEach{$0.isActive = true}
    }
    // MARK: - setup people collection view
    func setupPeopleCollectionView(){
        footerView.addSubview(peopleCollectionView)
        peopleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        [
            peopleCollectionView.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10),
            peopleCollectionView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            peopleCollectionView.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            peopleCollectionView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: 10)
        ].forEach{$0.isActive = true}
    }
}
