import UIKit

class CheckViewController: UIViewController {
    
    var orderedDishes: [(DishProtocol, Int)]!

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelTitle = UILabel(frame: CGRect(x: 10, y: 0, width: 200, height: 50))
        labelTitle.text = "Title"
        labelTitle.textColor = .black
        let labelCount = UILabel(frame: CGRect(x: 210, y: 0, width: 100, height: 50))
        labelCount.text = "Count"
        let labelPrice = UILabel(frame: CGRect(x: 310, y: 0, width: 80, height: 50))
        labelPrice.text = "Price"
        self.scrollView.addSubview(labelTitle)
        self.scrollView.addSubview(labelCount)
        self.scrollView.addSubview(labelPrice)
        var totalPrice: Float = 0.0
        for (number,(orderedDish, count)) in orderedDishes.enumerated() {
            let labelForTitle = UILabel(frame: CGRect(x: 10, y: 50 + 50 * number, width: 200, height: 50))
            labelForTitle.text = orderedDish.title
            let labelForCount = UILabel(frame: CGRect(x: 210, y: 50 + 50 * number, width: 100, height: 50))
            labelForCount.text = String(count)
            let labelForPrice = UILabel(frame: CGRect(x: 310, y: 50 + 50 * number, width: 80, height: 50))
            labelForPrice.text = String(orderedDish.price * Float(count)) + "$"
            self.scrollView.addSubview(labelForTitle)
            self.scrollView.addSubview(labelForCount)
            self.scrollView.addSubview(labelForPrice)
            totalPrice += orderedDish.price * Float(count)
        }
        let labelStrip = UILabel(frame: CGRect(x: 10, y: 50 + 50 * orderedDishes.count, width: 380, height: 15))
        labelStrip.text = "__________________________________________"
        self.scrollView.addSubview(labelStrip)
        let labelForTotalPrice = UILabel(frame: CGRect(x: 10, y: 65 + 50 * orderedDishes.count, width: 350, height: 50))
        labelForTotalPrice.text = "Total: \(totalPrice)$"
        labelForTotalPrice.textAlignment = .right
        labelForTotalPrice.font = .boldSystemFont(ofSize: 20)
        self.scrollView.addSubview(labelForTotalPrice)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
