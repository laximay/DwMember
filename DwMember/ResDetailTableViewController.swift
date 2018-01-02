//
//  ResDetailTableViewController.swift
//  DwMember
//
//  Created by wenjing on 2017/9/8.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit

class ResDetailTableViewController: UITableViewController {
    
    var resDetail: DwReservationReList? =  nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resCell", for: indexPath) as! ResDetailTableViewCell
        
        
        cell.backgroundColor = UIColor.clear //透明色
        switch indexPath.row {
        case 0:
            cell.nameLab.text = NSLocalizedString("status", comment: "訂座狀態")
            cell.valueLab.text = self.resDetail?.iscomfrim == "0" ? NSLocalizedString("Waiting for confirmation", comment: "待確認") : NSLocalizedString("Confirmed", comment: "已確認")
        case 1:
            cell.nameLab.text = NSLocalizedString("CardNo", comment: "會員卡號")
            cell.valueLab.text = self.resDetail?.cardno
        case 2:
            cell.nameLab.text = NSLocalizedString("Shop Name", comment: "店鋪名稱")
            cell.valueLab.text = self.resDetail?.branch.name1
        case 3:
            cell.nameLab.text =  NSLocalizedString("Address", comment: "店鋪地址")
            cell.valueLab.text = self.resDetail?.branch.addr
            
        case 4:
            cell.nameLab.text = NSLocalizedString("Tel No.", comment: "店鋪電話")
            cell.valueLab.text = self.resDetail?.branch.tel
        case 5:
            cell.nameLab.text = NSLocalizedString("Booking Time", comment: "預訂時間")
            cell.valueLab.text =  (self.resDetail?.indate!)! + " " +  (self.resDetail?.intime!)!
        case 6:
    
            
              let persons = self.resDetail?.persons.map{ "\($0.viewName!):\($0.personNum!)" }.joined(separator: ",")
            
            cell.nameLab.text = NSLocalizedString("Person", comment: "預訂位數")
            cell.valueLab.text = (self.resDetail?.person)!+"(\(persons!))"
        case 7:
            cell.nameLab.text = NSLocalizedString("Remark", comment: "備註信息")
            
            let remarks = self.resDetail?.remarks.map{ "\($0.remarkName!)" }.joined(separator: ";")
            cell.valueLab.text = remarks
        case 8:
            cell.nameLab.text = NSLocalizedString("Reserved food", comment: "預留食品")
             let meals = self.resDetail?.meals.map{ "\($0.meal!) ：\($0.total!)" }.joined(separator: ";")
            cell.valueLab.text = meals
        case 9:
            cell.nameLab.text = NSLocalizedString("tableNo", comment: "分配桌臺")
            
             cell.valueLab.text =  self.resDetail?.tableNo
            
       
            
        default:
            break
        }


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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
