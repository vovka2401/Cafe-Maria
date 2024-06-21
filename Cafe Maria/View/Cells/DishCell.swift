import UIKit

class DishCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
