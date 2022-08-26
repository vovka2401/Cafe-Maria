//
//  OrderViewController.swift
//  Cafe Maria
//
//  Created by Volodymyr Khvaliuk on 15.08.2022.
//

import UIKit

class OrderViewController: UIViewController {

    var dishesDB = DishDB.shared
    var dishes: [DishProtocol] = []
    var orderedDishes: [(DishProtocol, Int)] = []
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indexChanged()
    }
    
    @IBAction func indexChanged() {
        dishes = dishesDB.getDishesByType(type: DishType(rawValue: segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!)!)
        tableView.reloadData()
    }

    @IBAction func checkOrder() {
        guard !orderedDishes.isEmpty else {
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditOrderViewController") as! EditOrderViewController
        viewController.orderedDishes = self.orderedDishes
        viewController.orderViewController = self
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func logout() {
        let alertController = UIAlertController(title: "Are you sure to log out?", message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default){_ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.orderedDishes = []
            self.navigationController?.viewControllers = [viewController]
        }
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func editOrderedDishes(dish: DishProtocol, count: Int) {
        for (number, (orderedDish, _)) in orderedDishes.enumerated() {
            if dish.title == orderedDish.title {
                if count > 0 {
                    orderedDishes[number].1 = count
                } else {
                    orderedDishes.remove(at: number)
                }
                return
            }
        }
        if count > 0 {
            orderedDishes.append((dish, count))
        }
    }
}

extension OrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getConfiguredDishCell(for: indexPath) as! DishCell
        cell.title.text = dishes[indexPath.row].title
        cell.ingredients.text = dishes[indexPath.row].ingredients
        cell.price.text = "\(dishes[indexPath.row].price)$"
        cell.picture.image = dishes[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //загружаем следующий viewcontroller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DishViewController") as! DishViewController
        viewController.dish = dishes[indexPath.row]
        viewController.orderViewController = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func getConfiguredDishCell(for indexPath: IndexPath) -> UITableViewCell {
        // загружаем прототип ячейки по идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath) as! DishCell
        cell.title.textColor = .black
        return cell
    }
}
