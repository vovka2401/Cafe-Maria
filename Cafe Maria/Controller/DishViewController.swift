import UIKit

class DishViewController: UIViewController {
    
    var dish: DishProtocol!
    var orderViewController: OrderViewController!

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var titleDish: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var descriptionDish: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var totalCountOfDishes: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.value = Double(getElementByInstance(dish)?.1 ?? 0)
        picture.image = dish.image
        titleDish.text = dish.title
        price.text = "\(dish.price)$"
        weight.text = "\(dish.weight)g"
        descriptionDish.text = dish.description
        valueChanged()
    }
    
    @IBAction func valueChanged() {
        totalCountOfDishes.text = "Count: \(Int(stepper.value))"
        totalPrice.text = "Total: \(Double(dish.price)*stepper.value)$"
    }
    
    @IBAction func logout() {
        let alertController = UIAlertController(title: "Are you sure to log out?", message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default){_ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.orderViewController.orderedDishes = []
            self.navigationController?.viewControllers = [viewController]
        }
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getElementByInstance(_ dish: DishProtocol) -> (DishProtocol, Int)?{
        for (orderedDish, count) in orderViewController.orderedDishes {
            if orderedDish.title == dish.title && orderedDish.type == dish.type{
                return (orderedDish, count)
            }
        }
        return nil
    }
    
    deinit {
        orderViewController.editOrderedDishes(dish: dish, count: Int(stepper.value))
    }
}
