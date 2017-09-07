//
//  CompanyMapViewController.swift
//  PrinceCRM
//
//  Created by mikewang on 2017/9/6.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit
import MapKit

class CompanyMapViewController: UIViewController {

    // 用來存放公司資料
    var company = Company()
    
    @IBOutlet weak var companyMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 開始設定地圖
        getCoordinate(company.address) { (location) in
            guard let location = location else { return }
            let xScale:CLLocationDegrees = 0.001
            let yScale:CLLocationDegrees = 0.001
            let span:MKCoordinateSpan = MKCoordinateSpanMake(xScale, yScale)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            self.companyMapView.setRegion(region, animated: true)
            self.companyMapView.isZoomEnabled = true
            
            // 設定地圖標記，標題為公司名稱，副標題為公司地址
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "\(self.company.companyname)"
            annotation.subtitle = "\(self.company.address)"
            self.companyMapView.addAnnotation(annotation)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension CompanyMapViewController {
    // 透過地址取得地圖的座標
    func getCoordinate(_ address:String, completion: @escaping (CLLocationCoordinate2D?) -> ()) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard error == nil else {
                print("error: \(error)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }

}
