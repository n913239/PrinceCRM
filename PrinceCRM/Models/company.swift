//
//  company.swift
//  PrinceCRM
//
//  Created by mikewang on 2017/8/29.
//  Copyright © 2017年 mike. All rights reserved.
//

public class company
{
    var id:Int
    var companyname:String
    var address:String
    var tel:String
    var fax:String
    var email:String
    var website:String
    var employeesnumber:Int
    
    init(){
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
}
