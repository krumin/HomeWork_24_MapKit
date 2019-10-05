//
//  MapViewController.swift
//  HomeWork_24
//
//  Created by MAC OS  on 01.10.2019.
//  Copyright © 2019 MAC OS . All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  
  var address: FavoriteAddress!
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //CLGeocoder из текстового формата адреса преобразует в долготу и ширину или наоборот
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(address.address) { (placemarks, error) in
      
      guard error == nil else { return }
      guard let placemarks = placemarks else { return }
      
      let placemark = placemarks.first!
      
      //аннотация
      let annotation = MKPointAnnotation()
      annotation.title = self.address.name
      
      //координаты для аннотации
      guard let location = placemark.location else { return }
      annotation.coordinate = location.coordinate
      
      //отображение
      self.mapView.showAnnotations([annotation], animated: true)
      self.mapView.selectAnnotation(annotation, animated: true)
    }
  }
}

//Метод делегата

extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard !(annotation is MKUserLocation) else { return nil }
    
    let annotationIdentifier = "annotation"
    
    //аннотация с иголочкой MKPinAnnotationView или без MKAnnotationView
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
    
    if annotationView == nil {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
      
      //canShowCallout - для отображения дополнительной информации
      annotationView?.canShowCallout = true
    }
    
    //рамка для аннотации
    let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    rightImage.image = UIImage(named: "icons")
    
    //rightCalloutAccessoryView - правая часть рамки AccessoryView
    annotationView?.rightCalloutAccessoryView = rightImage
    annotationView?.pinTintColor = .red
    return annotationView
  }
}
