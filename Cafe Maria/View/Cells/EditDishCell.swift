import UIKit

class EditDishCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
