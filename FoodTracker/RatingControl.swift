//create a view in one of two ways:
//initializing the view with a frame so you can manually add the view to 
//your UI
//allow the view to be loaded by the storyboard

import UIKit

class RatingControl: UIView {
    
    //MARK: Properties
    
    //added a property observer to observe and respond to changes in the property's value - called every time
    //a property's value is set, and can be used to perform work immediately before or after teh value changes
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var ratingButtons = [UIButton]()
    var spacing = 5
    var stars = 5

    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        //loop to create 5 buttons - all stacked on top of each other
        for _ in 0..<stars {
            //create a single button
            let button = UIButton()
            
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            
            button.adjustsImageWhenHighlighted = false
            
            //button.backgroundColor = UIColor.greenColor()
        
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
        
            ratingButtons += [button]
            
            addSubview(button)
        }
    }
    
    //tells the stack view how to lay out the button - matches the size
    //set in the interface builder
    override func intrinsicContentSize() -> CGSize {
        
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        
        return CGSize(width: width, height: buttonSize)
    }
    
    override func layoutSubviews() {
        //set the button's width and height to a square the size of the frame's height
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        //Offset each button's origin by the length of the button plus spacing
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonsSelectionStates()
    }
    
    //MARK: Button Action
    
    func ratingButtonTapped(button: UIButton) {
        //print("Button Pressed 👍")
        
        rating = ratingButtons.indexOf(button)! + 1
        //indexOf attempts to find the selected button in the array of buttons and to return the index 
        //at which it was found - returns an optional Int because the instance you're searching for might not
        //exist in the collection you're searching
        //! = force unwrap operator
        
        updateButtonsSelectionStates()
    }
    
    func updateButtonsSelectionStates() {
        
        for (index, button) in ratingButtons.enumerate() {
            //if the index of a button is less than the rating, that button should be selected
            button.selected = index < rating
            
            //iterates through the button array to set the state of each button according to whether its index
            //in the array is less than the rating.  if index < rating is true, sets the button's state to selected
            //and makes it display the filled-in star image
        }
        
    }

}
