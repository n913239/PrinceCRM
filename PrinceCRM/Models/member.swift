//
//  member.swift
//  PrinceCRM
//
//  Created by mikewang on 2017/8/27.
//  Copyright © 2017年 mike. All rights reserved.
//

public class member
{
    var username:String
    var token:String
    init()
    {
        username = ""
        token = ""
    }
    init (username:String, token:String = "")
    {
        self.username = username
        self.token = token
    }
}
