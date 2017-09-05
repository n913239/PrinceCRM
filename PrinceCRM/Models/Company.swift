//
//  company.swift
//  PrinceCRM
//
//  Created by mikewang on 2017/8/29.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit

public class Company : Codable
{
    var id:Int
    var companyname:String
    var address:String
    var tel:String
    var fax:String
    var email:String
    var website:String
    var employeesnumber:Int
    
    init() {
        id = 0
        companyname = ""
        address = ""
        tel = ""
        fax = ""
        email = ""
        website = ""
        employeesnumber = 0
    }
    
    init(id:Int = 0, CompanyName:String = "", Address:String = "", Tel:String = "", Fax:String = "", Email:String = "", Website:String = "",EmployeesNumber:Int = 0) {
        self.id = id
        self.companyname = CompanyName
        self.address = Address
        self.tel = Tel
        self.fax = Fax
        self.email = Email
        self.website = Website
        self.employeesnumber = EmployeesNumber
    }
    
    // 取得索引
    func getStringFromIndex(_ index: Int) -> (String, String) {
        switch index {
        case 0:
            return ("編號", "\(id)")
        case 1:
            return ("名稱", companyname)
        case 2:
            return ("地址", address)
        case 3:
            return ("電話", tel)
        case 4:
            return ("傳真", fax)
        case 5:
            return ("電子郵件", email)
        case 6:
            return ("網站", website)
        case 7:
            return ("員工數", "\(employeesnumber)")
        default:
            return ("","")
        }
    }
    
    // 取得鍵盤類型索引
    func getKeyboardTypeFromIndex(_ index: Int) -> UIKeyboardType {
        switch index {
        case 0:
            // 編號
            return UIKeyboardType.default
        case 1:
            // 名稱
            return UIKeyboardType.default
        case 2:
            // 地址
            return UIKeyboardType.default
        case 3:
            // 電話
            return UIKeyboardType.phonePad
        case 4:
            // 傳真
            return UIKeyboardType.phonePad
        case 5:
            // 電子郵件
            return UIKeyboardType.emailAddress
        case 6:
            // website
            return UIKeyboardType.webSearch
        case 7:
            // 員工數
            return UIKeyboardType.numberPad
        default:
            return UIKeyboardType.default
        }
    }
    
    // 儲存公司資料用 傳入(Key, Value)
    func setCompanyProperty(_ key: String, value: String) {
        switch key {
        // 公司名稱
        case "text1": self.companyname = value
        // 地址
        case "text2": self.address = value
        // 電話
        case "text3": self.tel = value
        // 傳真
        case "text4": self.fax = value
        // 電子郵件
        case "text5": self.email = value
        // 網站
        case "text6": self.website = value
        // 員工數
        case "text7": self.employeesnumber = Int(value) ?? 0
        default: ""
        }
        
    }
    
}
