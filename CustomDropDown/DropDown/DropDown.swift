//
//  DropDown.swift
//  CustomDropDown
//
//  Created by Duy Tran on 17/08/2022.
//

import UIKit

protocol dropDownProtocol {
    func dropDownPressed(string : String)
}

class DropDown: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    
    var dropView = DropDownCell()
    var height = NSLayoutConstraint()
    var isOpen = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSuperView()
    }
    
    func initSuperView() {
        let nib = UINib(nibName: "DropDown", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]

        contentView.frame = bounds
        addSubview(contentView)
        setupUI()
    }
    
    override func didMoveToSuperview() {
        
        if superview == nil {
            
        } else {
            self.superview?.addSubview(dropView)
            self.superview?.bringSubviewToFront(dropView)
            dropView.topAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            dropView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            dropView.widthAnchor.constraint(equalTo: line.widthAnchor).isActive = true
            height = dropView.heightAnchor.constraint(equalToConstant: 0)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            
            if self.dropView.tableView.contentSize.height > 150 {
                self.height.constant = 150
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            
            
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
            
        } else {
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }

    
    func setupUI() {
        contentView.backgroundColor = UIColor.white
        
        titleLbl.font = .systemFont(ofSize: 13, weight: .medium)
        titleLbl.textColor = UIColor.rgbColor(red: 144, green: 144, blue: 144, alpha: 1)
        titleLbl.text = "Title"
        
        inputTF.textColor = UIColor.rgbColor(red: 47, green: 47, blue: 47, alpha: 1)
        inputTF.font = .systemFont(ofSize: 17, weight: .medium)
        
        icon.image = UIImage(named: "DropDownIc")
        
        line.backgroundColor = UIColor.rgbColor(red: 144, green: 144, blue: 144, alpha: 1)
        
        contentView.addSubview(dropView)
        
        dropView = DropDownCell.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupDropDown(inputTitle: String, isRequired: Bool, isDropDown: Bool, option: [String]) {
        titleLbl.text = inputTitle
        if isRequired {
            var a = inputTitle + "*"
            titleLbl.setText(a, withColorPart: "*", color: .red)
        }
        
        if isDropDown {
            inputTF.isUserInteractionEnabled = false
            contentView.isUserInteractionEnabled = true
            dropView.dropDownOptions = option
        }
        
    }
    
        
}

extension DropDown: dropDownProtocol {
    func dropDownPressed(string: String) {
        inputTF.text = string
        dismissDropDown()
    }
}

extension UIColor {
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

extension UILabel {

    func setText(_ text: String, withColorPart colorTextPart: String, color: UIColor) {
        attributedText = nil
        let result =  NSMutableAttributedString(string: text)
        result.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSString(string: text.lowercased()).range(of: colorTextPart.lowercased()))
        attributedText = result
    }

}
