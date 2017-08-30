//
//  company.swift
//  PrinceCRM
//
//  Created by mikewang on 2017/8/29.
//  Copyright © 2017年 mike. All rights reserved.
//

public class Company
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
    
    
}
