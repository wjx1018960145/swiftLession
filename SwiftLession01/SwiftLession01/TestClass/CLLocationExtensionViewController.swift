//
//  CLLocationExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/6.
//

import UIKit
import CoreLocation
class CLLocationExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["地理信息反编码", "地理信息编码"]]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - 一、基本的扩展
extension CLLocationExtensionViewController {
    
    // MARK: 1.2、地理信息编码
    @objc func test12() {
        CLLocation.jx.locationEncode(address: "南京市新街口大洋百货") { (placemarks:[CLPlacemark]?, error:Error?) in
            if error != nil {
                print("错误：\(error!.localizedDescription))")
                return
            }
            if let p = placemarks?[0]{
                print("经度：\(p.location!.coordinate.longitude)" + "纬度：\(p.location!.coordinate.latitude)")
            } else {
                print("No placemarks!")
            }
        }
    }
    
    // MARK: 1.1、地理信息反编码
    @objc func test11() {
        CLLocation.jx.reverseGeocode(latitude: 32.029171, longitude: 118.788231) { (placemarks: [CLPlacemark]?, error: Error?) in
            //强制转成简体中文
            let array = NSArray(object: "zh-hans")
            UserDefaults.standard.set(array, forKey: "AppleLanguages")
            //显示所有信息
            if error != nil {
                print("错误：\(error!.localizedDescription))")
                return
            }
            
            if let p = placemarks?[0]{
                print(p) //输出反编码信息
                var address = ""
                
                if let country = p.country {
                    address.append("国家：\(country)\n")
                }
                if let administrativeArea = p.administrativeArea {
                    address.append("省份：\(administrativeArea)\n")
                }
                if let subAdministrativeArea = p.subAdministrativeArea {
                    address.append("其他行政区域信息（自治区等）：\(subAdministrativeArea)\n")
                }
                if let locality = p.locality {
                    address.append("城市：\(locality)\n")
                }
                if let subLocality = p.subLocality {
                    address.append("区划：\(subLocality)\n")
                }
                if let thoroughfare = p.thoroughfare {
                    address.append("街道：\(thoroughfare)\n")
                }
                if let subThoroughfare = p.subThoroughfare {
                    address.append("门牌：\(subThoroughfare)\n")
                }
                if let name = p.name {
                    address.append("地名：\(name)\n")
                }
                if let isoCountryCode = p.isoCountryCode {
                    address.append("国家编码：\(isoCountryCode)\n")
                }
                if let postalCode = p.postalCode {
                    address.append("邮编：\(postalCode)\n")
                }
                if let areasOfInterest = p.areasOfInterest {
                    address.append("关联的或利益相关的地标：\(areasOfInterest)\n")
                }
                if let ocean = p.ocean {
                    address.append("海洋：\(ocean)\n")
                }
                if let inlandWater = p.inlandWater {
                    address.append("水源，湖泊：\(inlandWater)\n")
                }
                print(address)
            } else {
                print("No placemarks!")
            }
        }
        print("地理信息反编码")
    }
}

