//
//  CompanyTableViewController.swift
//  PrinceCRM
//
//  Created by mikewang on 2017/8/28.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit

class CompanyTableViewController: UITableViewController {

    var companys:[Company] = [Company]()
    func loadCompanys() {
        // 首先取得UserDefaults的會員資料
        let userDefault = UserDefaults.standard
        let user =  userDefault.string(forKey: "user")!
        let token = userDefault.string(forKey: "token")!
        
        
        let url = URL(string: "http://localhost:5000/api/Company/GetCompanyAll")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dictionary = ["username": user, "token": token]
        
        do {
            let data = try  JSONSerialization.data(withJSONObject: dictionary, options: [])
            
            let task = URLSession.shared.uploadTask(with: urlRequest, from: data, completionHandler: { (retData, res, error) in
                if let returnData = retData, let arr = (try? JSONSerialization.jsonObject(with: returnData)) as? NSArray, let dics = arr as? [[String:Any]] {
                    
                    for c in dics {
                        let company = Company(id: c["id"]! as! Int, CompanyName: c["companyname"]! as! String, Address: c["address"]! as! String, Tel: c["tel"]! as! String, Fax: c["fax"]! as! String, Email: c["email"]! as! String, Website: c["website"]! as! String, EmployeesNumber: c["employeesnumber"]! as! Int)
                        self.companys.append(company)
                    }
                    // 更新UI
                    self.updateUI()
                } else {
                    DispatchQueue.main.async(execute: {
                        self.showAlert(withTitle: "Warning", andMessage: "username or password incorrect", choiceMode: UIAlertControllerStyle.alert)
                    })
                }
            })
            task.resume()
        }
        catch { }
    }
    
    // 彈出警告視窗
    func showAlert(withTitle title:String, andMessage message:String, choiceMode  mode:UIAlertControllerStyle) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: mode)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // 更新UI
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCompanys()
        print("load")
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
        return companys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "\(indexPath.row + 1 ). \(companys[indexPath.row].companyname)"

        return cell
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
        
        if let companyDetails = segue.destination as? CompanyDetailsTableViewController, let indexPath = tableView.indexPathForSelectedRow {
            companyDetails.company = companys[indexPath.row]
        }
        
    }
    

}
