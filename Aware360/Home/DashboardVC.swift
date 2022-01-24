//
//  DashboardVC.swift
//  Nachme
//
//  Created by Quad on 11/19/20.
//  Copyright © 2020 claritaz. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import Alamofire
import Polyline
import ACFloatingTextfield_Swift
import KYDrawerController
import JGProgressHUD
import SCLAlertView
import GooglePlaces
import GooglePlacePicker
import CoreData

class DashboardVC: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate {

    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var myMapView: GMSMapView!
    private let locationManager = CLLocationManager()
    var marker:GMSMarker?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var searchlat : Double?
    var searchlong : Double?
    var OnserachLocMAp : Bool = false
    @IBOutlet weak var searchbtn: UIButton!
    @IBOutlet weak var seachTxtfld: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchview: UIView!
    var textfldselected : Int?
    var currLang : String?
    var adress : String?
    var destinationMarker : GMSMarker!
    var destinationCoordinate : CLLocationCoordinate2D!
    var isfromEdithome : Bool = false
    var whichtxtfld : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        self.myMapView.settings.scrollGestures = true
        self.myMapView.settings.zoomGestures = true
        self.myMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 75, right: 0)
        confirmBtn.layer.cornerRadius = 15
        confirmBtn.layer.masksToBounds = false
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.searchview.layer.cornerRadius = 15
        self.searchview.layer.masksToBounds = false
        self.searchview.layer.borderColor = UIColor(displayP3Red: 4/255, green: 51/255, blue: 55/255, alpha: 1.0).cgColor
        self.searchview.layer.borderWidth = 1.0
        currLang = LocalizationSystem.sharedInstance.getLanguage()
         if(self.currLang == "en"){
            self.seachTxtfld.textAlignment = .left
            
        }else
         {
            self.seachTxtfld.textAlignment = .right

        }
        self.languageTranslation()
    }
    func languageTranslation()
        {
            confirmBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Confirm Location", comment: ""), for: .normal)
            seachTxtfld.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Search", comment: "")
    }
    @IBAction func searchAction(_ sender: UIButton) {
        let autoCompleteController = GMSAutocompleteViewController()
                                     autoCompleteController.delegate = self
                                  
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Search", comment: "") , attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                                  
         let filter = GMSAutocompleteFilter()
                                     
        autoCompleteController.autocompleteFilter = filter
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    // MARK: - GOOGLE AUTO COMPLETE DELEGATE
         func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
              let lat = place.coordinate.latitude
              let long = place.coordinate.longitude
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 14.0)
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
                let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = long
            self.searchlat = lat
            self.searchlong = long
            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
            ceo.reverseGeocodeLocation(loc, completionHandler:
                    {(placemarks, error) in
                        if (error != nil)
                        {
                            print("reverse geodcode fail: \(error!.localizedDescription)")
                        }
                        let pm = placemarks! as [CLPlacemark]
                        if pm.count > 0
                        {
                            let pm = placemarks![0]
                         let country = pm.country ?? ""
                         let state = pm.administrativeArea ?? ""
                         let city = pm.locality ?? ""
                         var addDict : NSArray?
                       for(_, elem) in (pm.addressDictionary?.enumerated())!
                       {
                           if(elem.key as? String == "FormattedAddressLines")
                           {
                                addDict = elem.value as? NSArray
                           }
                       }
                            self.adress = addDict?.componentsJoined(by: ",")
                            self.seachTxtfld.text = self.adress
                            if(self.textfldselected == 2)
                            {
                                if(self.OnserachLocMAp)
                                {
                                    UserDefaults.standard.set(self.adress, forKey: "drophome")

                                }else{
                                    UserDefaults.standard.set(self.adress, forKey: "Pindropadd")

                                }
                            }else
                            {
                                if(self.OnserachLocMAp)
                                {
                                    UserDefaults.standard.set(self.adress, forKey: "pickhome")

                                }else{
                                    UserDefaults
                                    .standard.set(self.adress, forKey: "Pinpickadd")
                                }
                                

                            }
                            self.locationManager.startUpdatingLocation()
                          if(pm.locality != ""){
                            UserDefaults.standard.set(pm.locality ?? "", forKey: "mapname")
                          }
                          else {
                             UserDefaults.standard.set(pm.administrativeArea ?? "", forKey: "mapname")
                          }
                           self.dismiss(animated: true, completion: nil) // dismiss after place selected
                        }
                })
          }
          
          func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
              print("ERROR AUTO COMPLETE \(error)")
          }
          
          func wasCancelled(_ viewController: GMSAutocompleteViewController) {
              self.dismiss(animated: true, completion: nil)
          }
    
    @IBAction func confirmLocation(_ sender: UIButton) {
        if(self.adress == nil){
                         self.searchlat = destinationCoordinate.latitude
                         self.searchlong = destinationCoordinate.longitude

                    var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
                     let ceo: CLGeocoder = CLGeocoder()
                     center.latitude = destinationCoordinate.latitude
                     center.longitude = destinationCoordinate.longitude
                                                   
                     let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
                     ceo.reverseGeocodeLocation(loc, completionHandler:
                                       {(placemarks, error) in
                                           if (error != nil)
                                           {
                                               print("reverse geodcode fail: \(error!.localizedDescription)")
                                           }
                                           let pm = placemarks! as [CLPlacemark]
                                           if pm.count > 0
                                           {
                                               let pm = placemarks![0]
                                               
                                               var addDict : NSArray?
                                               for(_, elem) in (pm.addressDictionary?.enumerated())!
                                               {
                                                   if(elem.key as? String == "FormattedAddressLines")
                                                   {
                                                        addDict = elem.value as? NSArray
                                                   }
                                               }
                                               
            self.adress = addDict?.componentsJoined(by: ",")
                                              if(self.textfldselected == 2)
                                              {
                                                if(self.OnserachLocMAp)
                                                {
                                                    UserDefaults.standard.set(self.adress, forKey: "drophome")
                                                }else{
                                                  UserDefaults.standard.set(self.adress, forKey: "Pindropadd")
                                                }
                                                 
                                                

                                                  
                                              }else
                                              {
                                                if(self.OnserachLocMAp)
                                                {
                                                    UserDefaults.standard.set(self.adress, forKey: "pickhome")

                                                }else{
                                                UserDefaults.standard.set(self.adress, forKey: "Pinpickadd")
                                                }
                                                

                                              }
                                            self.showSimpleAlert(addrss: self.adress!)

                                           }
                                   })
        }else
        {
            self.showSimpleAlert(addrss: self.adress!)

        }
    }
   
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
         myMapView.clear()
                     let marker = GMSMarker()
                     marker.position = coordinate
                      var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
                                    let ceo: CLGeocoder = CLGeocoder()
                                center.latitude = coordinate.latitude
                                center.longitude = coordinate.longitude
                                    
                                    let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
                                    ceo.reverseGeocodeLocation(loc, completionHandler:
                                        {(placemarks, error) in
                                            if (error != nil)
                                            {
                                                print("reverse geodcode fail: \(error!.localizedDescription)")
                                            }
                                           
                                            let pm = placemarks! as [CLPlacemark]
                                            if pm.count > 0
                                            {
                                              
                                                let pm = placemarks![0]
                                                let country = pm.country ?? ""
                                              let state = pm.administrativeArea ?? ""
                                                let city = pm.locality ?? ""
                                               if let locationName = pm.location {
                                  print(locationName)
                                                                                      }
                                                var addDict : NSArray?
                                                for(_, elem) in (pm.addressDictionary?.enumerated())!
                                                {
                                                    if(elem.key as? String == "FormattedAddressLines")
                                                    {
                                                         addDict = elem.value as? NSArray
                                                    }
                                                }
                                               self.adress = addDict?.componentsJoined(by: ",")
                                               self.searchlat = coordinate.latitude
                                               self.searchlong = coordinate.longitude
                                                marker.title = self.adress
                                              if(self.textfldselected == 2)
                                              {
                        if(self.OnserachLocMAp)
                        {
                          UserDefaults.standard.set(self.adress, forKey: "drophome")
                        }
                        else
                        { UserDefaults.standard.set(self.adress, forKey: "Pindropadd")
                            
                                                }
                                                 
                                                

                                                  
                                              }else
                                              {
                    if(self.OnserachLocMAp)
                    {
                        UserDefaults.standard.set(self.adress, forKey: "pickhome")
                    
                                                }
                                                else
                    {
                        UserDefaults
                        .standard.set(self.adress, forKey: "Pinpickadd")

                                                }
                                                  
                                              }
                                              self.showSimpleAlert(addrss: self.adress!)
                                            }
                                    })
                      marker.icon = UIImage(named:"Image")
                      marker.map = mapView
    }

    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - showSimpleAlert
       func showSimpleAlert(addrss : String) {
               
               let myString = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Cancel", comment: "")
               let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.lightGray ]
               let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
               
           let alert = UIAlertController(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Are you sure the home address?", comment: "")
       ,   message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "You can change the location if you want again!", comment: ""), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:LocalizationSystem.sharedInstance.localizedStringForKey(key: "Confirm", comment: "")
       ,
                                             style: UIAlertAction.Style.default,
                                             handler: {(_: UIAlertAction!) in
                                               if(self.searchlat == nil && self.searchlat == nil)
                                               {
                                let appearance = SCLAlertView.SCLAppearance(
                                                          showCloseButton: false
                                                      )
                               let alertView = SCLAlertView(appearance: appearance)
                                                    if(self.currLang == "en"){
                                                    alertView.addButton("Done", target: self, selector: #selector(self.sucessAlertAction))
                                                    alertView.showError("Error", subTitle: "Please Locate your property on the map")
                                                   }
                                                    else{
                                                        alertView.addButton("منجز", target: self, selector: #selector(self.sucessAlertAction))
                                                        alertView.showError("خطأ", subTitle: "يرجى تحديد الممتلكات الخاصة بك على الخريطة")
                                                   }
                                               }else
                                               {
                    if(self.isfromEdithome)
                    {
                        if(self.whichtxtfld == 1)
                        {
                            self.savePickUpDataInCoreData()
                            UserDefaults.standard.set(self.searchlat, forKey: "passPickUpLat")
                            UserDefaults.standard.set(self.searchlong, forKey: "passPickUpLong")
                            UserDefaults.standard.set(self.adress, forKey: "pickaddress")
                            self.navigationController?.popViewController(animated: true)
                        }else
                        {
                            self.saveDropDataInCoreData()
                UserDefaults.standard.set(self.searchlat, forKey: "passDropLat")
               UserDefaults.standard.set(self.searchlong, forKey: "passDropLong")
               UserDefaults.standard.set(self.adress, forKey: "dropaddress")
               self.navigationController?.popViewController(animated: true)
                        }
                    }else{
                    
               let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let newViewController = storyBoard.instantiateViewController(withIdentifier: "SetUpLocationVC") as! SetUpLocationVC
                                                   newViewController.pinPointStatus = 1
                                                newViewController.passtextflsSelected = self.textfldselected ?? 0
                                                   newViewController.pinvalue = addrss
                                                
                          if(self.textfldselected == 2)
                        {
                            if(self.OnserachLocMAp)
                            {                            UserDefaults.standard.set(self.adress, forKey: "drophome")
                                newViewController.homelat = self.searchlat
                                newViewController.homelong = self.searchlong
                            }
                            else{
                UserDefaults.standard.set(self.adress, forKey: "Pindropadd")
                                newViewController.pinlat = self.searchlat
                                newViewController.pinlong = self.searchlong
                            }
                            
                        }else
                        {
                            if(self.OnserachLocMAp)
                            {
                        UserDefaults.standard.set(self.adress, forKey: "pickhome")
                                newViewController.homelat = self.searchlat
                                newViewController.homelong = self.searchlong
                            }
                            else
                            {
                                UserDefaults.standard.set(self.adress, forKey: "Pinpickadd")
                                newViewController.pinlat = self.searchlat
                                newViewController.pinlong = self.searchlong
                            }
                        }
                        newViewController.onSETLOCATION = self.OnserachLocMAp
                        self.navigationController?.pushViewController(newViewController, animated: true)
                                                } }
               }))
               let action = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Cancel", comment: ""), style: UIAlertAction.Style.default, handler: { (_: UIAlertAction!) in
                                 self.dismiss(animated: true, completion: nil)
                                 })
                                 action.setValue(UIColor.lightGray, forKey: "titleTextColor")
                                 alert.addAction(action)
               self.present(alert, animated: true, completion: nil)
        }
       @objc func sucessAlertAction()
             {
                 
             }
    //MARK: - Save Data in Core data
       func savePickUpDataInCoreData()
       {
           let context = appDelegate.persistentContainer.viewContext
           let entity = NSEntityDescription.entity(forEntityName: "Pickup", in: context)
           let request = NSFetchRequest<NSFetchRequestResult>()
           request.entity = entity

           var Fetcherror: Error?
           let mutableFetchResults = try? context.fetch(request)
           
           if let mutableFetchResults = mutableFetchResults {
               let stringArray = mutableFetchResults.compactMap { ($0 as AnyObject).address}
            if stringArray.contains(self.adress) {
                    print("duplicates")
                    return
               }else{
                   let newUser = NSManagedObject(entity: entity!, insertInto: context)
                    newUser.setValue(self.adress, forKey: "address")
                newUser.setValue(searchlat, forKey: "lat")
                                            newUser.setValue(searchlong, forKey: "long")

                                            do {
                                               try context.save()
                                              } catch {
                                               print("Failed saving")
                                            }
               }
           }

       
       }
       func saveDropDataInCoreData()
          {
             let context = appDelegate.persistentContainer.viewContext
                    let entity = NSEntityDescription.entity(forEntityName: "Drop", in: context)
                    let request = NSFetchRequest<NSFetchRequestResult>()
                    request.entity = entity
           var Fetcherror: Error?
           let mutableFetchResults = try? context.fetch(request)
           
           if let mutableFetchResults = mutableFetchResults {
               let stringArray = mutableFetchResults.compactMap { ($0 as AnyObject).address}
            if stringArray.contains(self.adress) {
                    print("duplicates")
                    return
               }else{
                   let newUser = NSManagedObject(entity: entity!, insertInto: context)
                            newUser.setValue(self.adress, forKey: "address")
                            newUser.setValue(searchlat, forKey: "lat")
                                newUser.setValue(searchlong, forKey: "long")
                            do {
                               try context.save()
                              } catch {
                               print("Failed saving")
                            }
               }
            
           }}
      // Camera change Position this methods will call every time
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
           var destinationLocation = CLLocation()
          // if self.mapGesture == true
           //{
               destinationLocation = CLLocation(latitude: position.target.latitude,  longitude: position.target.longitude)
                destinationCoordinate = destinationLocation.coordinate
        updateLocationoordinates(coordinates: destinationCoordinate)
           //}
        
       }

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
                       let ceo: CLGeocoder = CLGeocoder()
        center.latitude = position.target.latitude
                         center.longitude = position.target.longitude
                    
                    let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
                    ceo.reverseGeocodeLocation(loc, completionHandler:
                        {(placemarks, error) in
                            if (error != nil)
                            {
                                print("reverse geodcode fail: \(error!.localizedDescription)")
                            }
                           if(placemarks != nil){
                           let pm = placemarks as! [CLPlacemark]
                            if pm.count > 0
                            {
                              
                                let pm = placemarks![0]
                                let country = pm.country ?? ""
                              let state = pm.administrativeArea ?? ""
                                let city = pm.locality ?? ""
                               if let locationName = pm.location {
                  print(locationName)
                                                                      }
                                var addDict : NSArray?
                                for(_, elem) in (pm.addressDictionary?.enumerated())!
                                {
                                    if(elem.key as? String == "FormattedAddressLines")
                                    {
                                         addDict = elem.value as? NSArray
                                    }
                                }
                               self.adress = addDict?.componentsJoined(by: ",")
                                self.searchlat = position.target.latitude
                                self.searchlong = position.target.longitude
                             self.seachTxtfld.text = self.adress
                            
                               }}
                    })
    }
    func updateLocationoordinates(coordinates:CLLocationCoordinate2D) {
           if destinationMarker == nil
           {
               destinationMarker = GMSMarker()
               destinationMarker.position = coordinates
            //   let image = UIImage(named:"arrow")
            //   destinationMarker.icon = image
            destinationMarker.map = self.myMapView
            destinationMarker.appearAnimation = .pop

           }
           else
           {
               CATransaction.begin()
               CATransaction.setAnimationDuration(1.0)
               destinationMarker.position =  coordinates
               CATransaction.commit()
           }
       }
    //MARK: - Location manager delegate
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
             
             guard status == .authorizedWhenInUse else {
                 return
             }
             
             locationManager.startUpdatingLocation()
             
           myMapView.delegate = self
             myMapView.isMyLocationEnabled = true
             myMapView.settings.myLocationButton = true
    }
         func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if(searchlat == nil && searchlong == nil){
             guard let location = locations.last else {
                 return
            }
             myMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            }
            else
            {
                let locCoordin = CLLocationCoordinate2D(latitude: self.searchlat!, longitude: self.searchlong!)
                myMapView.camera = GMSCameraPosition(target: locCoordin, zoom: 15, bearing: 0, viewingAngle: 0)
            }
             
             locationManager.stopUpdatingLocation()
            
         }
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
          UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
          image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
          let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
          UIGraphicsEndImageContext()
          return newImage
      }

}
