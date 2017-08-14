//
//  Activitys.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/1.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//項目前期創建臨時模型，等接入接口后要轉入CORE DATA存儲
//

struct Activitys {
    var title : String // 標題
    var aType : String //活動類型
    var thumbImage : String //縮略圖
    var bigImage : String //大圖
    var description : String //描述
    
    init(title : String,aType : String, thumbImage : String, bigImage : String, description : String ) {
        self.title = title
        self.aType = aType
        self.thumbImage = thumbImage
        self.bigImage = bigImage
        self.description = description
    }
    
    
    
}


