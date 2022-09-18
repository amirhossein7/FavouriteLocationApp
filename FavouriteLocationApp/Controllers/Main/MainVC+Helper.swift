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
    // MARK: - setup parent view for map
    func setupMapParentView() {
        mainSuperView.addSubview(mapParentView)
        mapParentView.translatesAutoresizingMaskIntoConstraints = false
        [
            mapParentView.topAnchor.constraint(equalTo: mainSuperView.topAnchor),
            mapParentView.leadingAnchor.constraint(equalTo: mainSuperView.leadingAnchor),
            mapParentView.trailingAnchor.constraint(equalTo: mainSuperView.trailingAnchor),
            mapParentView.bottomAnchor.constraint(equalTo: footerView.topAnchor)
        ].forEach{$0.isActive = true}
    }
    // MARK: - setup map
    func setupMapView() {
        let defaultLocation = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        let child = GoogleMapViewController(self, defaultCoordinate: defaultLocation)
        mapProtocol = child
        add(child: child, in: mapParentView)
        addMapConstraints(child)
    }
    func addMapConstraints(_ child: UIViewController){
        child.view.translatesAutoresizingMaskIntoConstraints = false
        [
            child.view.topAnchor.constraint(equalTo: mapParentView.topAnchor),
            child.view.leadingAnchor.constraint(equalTo: mapParentView.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: mapParentView.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: mapParentView.bottomAnchor)
        ].forEach{$0.isActive = true}
    }
    // MARK: - setup center marker
    func setupCenterMarker() {
        mapParentView.addSubview(centerMarkerButton)
        centerMarkerButton.translatesAutoresizingMaskIntoConstraints = false
        [
            centerMarkerButton.centerXAnchor.constraint(equalTo: mapParentView.centerXAnchor),
            centerMarkerButton.centerYAnchor.constraint(equalTo: mapParentView.centerYAnchor, constant: -30),
            centerMarkerButton.heightAnchor.constraint(equalToConstant: 60),
            centerMarkerButton.widthAnchor.constraint(equalToConstant: 60)
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
    // MARK: - setup cancel button
    func setupCancelButton() {
        mainSuperView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        [
            cancelButton.topAnchor.constraint(equalTo: mainSuperView.topAnchor, constant: 60),
            cancelButton.leadingAnchor.constraint(equalTo: mainSuperView.leadingAnchor, constant: 32),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.widthAnchor.constraint(equalToConstant: 50)
        ].forEach{$0.isActive = true}
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
    func setupPeopleCollectionView() {
        footerView.addSubview(peopleCollectionView)
        peopleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        [
            peopleCollectionView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 10),
            peopleCollectionView.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            peopleCollectionView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            peopleCollectionView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            peopleCollectionView.heightAnchor.constraint(equalToConstant: 70)
        ].forEach{$0.isActive = true}
    }

}
