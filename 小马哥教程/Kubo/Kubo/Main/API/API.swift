//
//  API.swift
//  Kubo
//
//  Created by wjx on 2023/9/21.
//

struct API {
    static let api = "http://192.168.43.148:8080"
 
    static func getImage(_ id:Int)->String{
        return "/video/getImg/\(id)"
    }
    static func getVideo()->String{
        return "/video/getAllVideos"
    }
}



