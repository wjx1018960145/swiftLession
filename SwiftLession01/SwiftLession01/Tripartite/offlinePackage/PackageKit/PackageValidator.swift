//
//  PackageValidator.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import Foundation

/**
 * 校验资源信息的有效性
 */
private protocol  PackageValidator {
   func validate(info:PackageInfo)->Bool;
}
