//
//  Job.swift
//  RecruitingJobList
//
//  Created by 大石 陽波 on 2019/09/20.
//  Copyright © 2019 Yoha Oishi. All rights reserved.
//

import Foundation

struct JsonResponse: Codable {
    var data: [Job]
}

struct Job: Codable {
    var company: CompanyInfo
    var image: ImageUrl
    var title: String
    var looking_for: String
}

struct CompanyInfo: Codable {
    var avatar: AvatarUrl
    var name: String
}

struct ImageUrl: Codable {
    var i_320_131: URL
}

struct AvatarUrl: Codable {
    var s_100: URL
}
