//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 8/8/2018.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    var restaurantIsVisted = Array(repeating: false, count:21 )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        //去除重复mark，自定义样式
//        if restaurantIsVisted[indexPath.row] == false {
//            cell.checkMaekImg.image = UIImage()
//        }else{
//            cell.checkMaekImg.image = UIImage(named: "heart-tick")
//        }
        //普通样式
//        cell.accessoryType = restaurantIsVisted[indexPath.row] ? .checkmark : .none
        
        // Configure the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        //取消动作
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)

        
        //加入call动作
        let callActioHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry,the feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }

        let callAction = UIAlertAction(title: "Call" + "123-000-\(indexPath.row)", style: .default, handler: callActioHandler)
        optionMenu.addAction(callAction)

        //check-in
        let checkInAction = UIAlertAction(title: "Check in", style: .default, handler: {
            (action:UIAlertAction) -> Void in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            //普通样式
//            cell?.accessoryType = .checkmark
            //自定义样式
            cell.checkMaekImg.image = UIImage(named: "heart-tick")
            self.restaurantIsVisted[indexPath.row] = true
        })

        //check-out
        let checkOutAction = UIAlertAction(title: "check out", style: .default, handler: {
            (ACTION:UIAlertAction) -> Void in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell;
            //普通样式
//            cell?.accessoryType = .none
            //自定义样式
            cell.checkMaekImg.image = UIImage()
            self.restaurantIsVisted[indexPath.row] = false
        })

        //判断使用checkIn or checkOut
        if restaurantIsVisted[indexPath.row]==false {
            optionMenu.addAction(checkInAction)
        }else{
            optionMenu.addAction(checkOutAction)
        }


        present(optionMenu, animated: true, completion: nil)

        //IPAD弹框优化，以防报错
        //iPhone弹框popoverPresentationController为nil
        //iPad弹框通过popoverPresentationController实现，非nil认为是iPad
        if let popoverController = optionMenu.popoverPresentationController{
            //配置源视图
            if let cell = tableView.cellForRow(at: indexPath){
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }

        //取消选中
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    

}
