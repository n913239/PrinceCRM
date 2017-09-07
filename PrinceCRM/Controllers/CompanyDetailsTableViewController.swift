//
//  CompanyDetailsTableViewController.swift
//  PrinceCRM
//
//  Created by mikewang on 2017/8/30.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit

class CompanyDetailsTableViewController: UITableViewController {

    @IBOutlet weak var longTextView: UITextView!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var shortTextField: UITextField!
    @IBOutlet weak var shortLabel: UILabel!
    @IBAction func viewTapped(_ sender: Any) {
        print("tapped")
        view.endEditing(true)
    }
    
    var company = Company()
    struct PropertyKeys {
        static let CompanyTableViewId = "CompanyList"
        static let CompanyNavigationId = "companyNavigationId"
    }
    
    
    // 儲存公司資料
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        // 先取得text的資料，並存回company
        let sections = numberOfSections(in: self.tableView)
        for section in 0..<sections {
            let rows = tableView(self.tableView, numberOfRowsInSection: section)
            for row in 0..<rows {
                let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) as! CompanyDetailsTableViewCell
                // 將資料存入company
                company.setCompanyProperty(cell.getTextFieldDic().0, value: cell.getTextFieldDic().1)
            }
        }
        // 將資料回存到web api
        saveCompanyToWebapi()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // 先判斷company 是否存在，並且有值
        //guard let company = self.company else { return 8 }
        let mirror = Mirror(reflecting: company)
        return mirror.children.count.hashValue >= 0 ? Int(mirror.children.count) : 8
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configure(indexPath)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "companyMap" {
            // 傳遞公司資料到地圖頁面
            if let companyMap = segue.destination as? CompanyMapViewController {
                companyMap.company = company
            }
        }
        
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.endEditing(true)
    }
    
    
}

extension CompanyDetailsTableViewController: UITextFieldDelegate, UITextViewDelegate {
    // return 按鍵收螢幕
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // 點擊螢幕收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
extension CompanyDetailsTableViewController {
    // 設定TableView的Cell資料
    func configure(_ indexPath:IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellLong", for: indexPath) as! CompanyDetailsTableViewCell
            guard let label = cell.longLabel else { return cell }
            guard let textField = cell.longTextView else { return cell }
            
            label.text = company.getStringFromIndex(indexPath.row).0
            textField.text = company.getStringFromIndex(indexPath.row).1
            textField.delegate = self
            textField.restorationIdentifier = "text\(indexPath.row)"
            
            // 設定鍵盤類型
            textField.keyboardType = company.getKeyboardTypeFromIndex(indexPath.row)
            
            return cell as UITableViewCell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellLongMap", for: indexPath) as! CompanyDetailsTableViewCell
            guard let label = cell.longLabel else { return cell }
            guard let textField = cell.longTextView else { return cell }
            
            label.text = company.getStringFromIndex(indexPath.row).0
            textField.text = company.getStringFromIndex(indexPath.row).1
            textField.delegate = self
            textField.restorationIdentifier = "text\(indexPath.row)"
            
            // 設定鍵盤類型
            textField.keyboardType = company.getKeyboardTypeFromIndex(indexPath.row)
            
            return cell as UITableViewCell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellShort", for: indexPath) as! CompanyDetailsTableViewCell
            guard let label = cell.shortLabel else { return cell }
            guard let textField = cell.shortTextField else { return cell }
            
            label.text = company.getStringFromIndex(indexPath.row).0
            textField.text = company.getStringFromIndex(indexPath.row).1
            textField.delegate = self
            textField.restorationIdentifier = "text\(indexPath.row)"
            
            // 設定鍵盤類型
            textField.keyboardType = company.getKeyboardTypeFromIndex(indexPath.row)
            
            return cell as UITableViewCell
        }
    }
    
    // 彈出警告視窗
    func showAlert(withTitle title:String, andMessage message:String, choiceMode  mode:UIAlertControllerStyle) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: mode)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            // 返回前一頁
            self.navigationController?.popViewController(animated: true)
            //self.performSegue(withIdentifier: "BackToCompanyListSegue", sender: self)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func saveCompanyToWebapi() {
        // 首先取得UserDefaults的會員資料
        let userDefault = UserDefaults.standard
        let user =  userDefault.string(forKey: "user")!
        let token = userDefault.string(forKey: "token")!
        
        // 判斷是修改還是新增公司資料 (id = 0 為新增)
        let webAction = company.id == 0 ? "Add" : "Update"
        let httpMethod = company.id == 0 ? "POST" : "PUT"
        let url = URL(string: "http://localhost:5000/api/Company/\(webAction)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = httpMethod
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        do {
            //let data = try  JSONEncoder().encode(company)
            let dictionary = ["id": "\(company.id)", "companyname":company.companyname, "address":company.address, "tel": company.tel, "fax": company.fax, "email": company.email, "website": company.website, "employeesnumber": "\(company.employeesnumber)", "username": user, "token": token]
            let data = try  JSONSerialization.data(withJSONObject: dictionary, options: [])
            
            let task = URLSession.shared.uploadTask(with: urlRequest, from: data, completionHandler: { (retData, res, error) in
                // 取得是否修改(新增)成功，成功的話會回傳1
                guard let retData = retData, let result = String(data: retData, encoding: String.Encoding.utf8) else { return }
            })
            task.resume()
        }
        catch { }
        // 提示儲存成功，並返回前一頁
        self.showAlert(withTitle: "公司資料", andMessage: "儲存成功", choiceMode: .alert)
    }
}
