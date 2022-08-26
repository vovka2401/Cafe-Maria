//
//  EditOrderViewController.swift
//  Cafe Maria
//
//  Created by Volodymyr Khvaliuk on 20.08.2022.
//

import UIKit

class EditOrderViewController: UIViewController {
    
    var orderedDishes: [(DishProtocol, Int)]!
    var orderViewController: OrderViewController!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func valueChanged(_ sender: UIStepper) {
        let cell = sender.superview?.superview as! EditDishCell
        let (dish, _) = getElementByTitle(title: cell.title.text!)!
        cell.count.text = "Count: \(Int(cell.stepper.value))"
        cell.totalPrice.text = "Total: \(Double(dish.price) * cell.stepper.value)$"
        self.editOrderedDishes(dish: dish, count: Int(cell.stepper.value))
    }
    
    @IBAction func order() {
        guard !self.orderedDishes.isEmpty else {
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CheckViewController") as! CheckViewController
        viewController.orderedDishes = self.orderedDishes
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
    
    func getElementByTitle(title: String) -> (DishProtocol, Int)?{
        for (orderedDish, count) in orderViewController.orderedDishes {
            if orderedDish.title == title {
                return (orderedDish, count)
            }
        }
        return nil
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
    
    deinit {
        orderViewController.orderedDishes = self.orderedDishes
    }
}

extension EditOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedDishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getConfiguredEditDishCell(for: indexPath) as! EditDishCell
        let (dish, count) = orderedDishes[indexPath.row]
        cell.title.text = dish.title
        cell.stepper.value = Double(count)
        cell.totalPrice.text = "Total: \(dish.price * Float(cell.stepper.value))$"
        cell.count.text = "Count: \(Int(cell.stepper.value))"
        cell.picture.image = dish.image
        return cell
    }
    
    func getConfiguredEditDishCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "editDishCell", for: indexPath) as! EditDishCell
        cell.title.textColor = .black
        return cell
    }
}
