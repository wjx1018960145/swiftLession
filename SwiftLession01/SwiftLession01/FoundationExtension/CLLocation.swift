//
//  CLLocation.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/6.
//


import Foundation
import CoreLocation

extension CLLocation: JXPOPCompatible {}

// MARK: - 一、基本的扩展
public extension JXPOP where Base == CLLocation {
 
    // MARK: 1.1、地理信息反编码
    /// 地理信息反编码
    /// - Parameters:
    ///   - latitude: 精度
    ///   - longitude: 纬度
    ///   - completionHandler: 回调函数
    static func reverseGeocode(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completionHandler: @escaping CLGeocodeCompletionHandler) {
        let geocoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: completionHandler)
    }
    
    // MARK: 1.2、地理信息编码
    /// 地理信息编码
    /// - Parameters:
    ///   - address: 地址信息
    ///   - completionHandler: 回调函数
    static func locationEncode(address: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: completionHandler)
    }
}
