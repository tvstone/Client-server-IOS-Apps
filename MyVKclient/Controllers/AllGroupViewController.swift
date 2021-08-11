//
//  AllGroupViewController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit

class AllGroupViewController: UITableViewController {

    var allGroup = [groupFriends]()

    let reuseIdentifareCellGroup = "reuseIdentifareCellGroup"
    
   
    
    
    func  setupGroup() -> [groupFriends] {
        var itogArray = [groupFriends]()
        
        let firstGroup = groupFriends(titleGroup: "Близкие друзья", avaGroup: UIImage(named: "1_3")!, variableDescriptionGroup: "Одноклассники")
        itogArray.append(firstGroup)
    
        let secondGroup = groupFriends(titleGroup: "Товарищи", avaGroup: UIImage(named: "1_4")!, variableDescriptionGroup: "Одноклассники")
        itogArray.append(secondGroup)
        
        return itogArray
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allGroup = setupGroup()
   
        self.tableView.register(UINib(nibName: "UniversalTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifareCellGroup)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allGroup.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifareCellGroup, for: indexPath) as? UniversalTableViewCell else {return UITableViewCell()}

        cell.configureCell(group: allGroup[indexPath.row])


        return cell
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        guard let cell = tableView.cellForRow(at: indexPath) as? UniversalTableViewCell,
              let cellObject = cell.saveObject as? groupFriends
              else {return}
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendGroup"), object: cellObject)
        
        self.navigationController?.popViewController(animated: true)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
