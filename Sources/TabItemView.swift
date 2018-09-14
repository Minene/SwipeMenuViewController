import UIKit

public enum TitleImagePosition {
    case left
    case right
}

final class TabItemView: UIView {
    
    private(set) var titleLabel: UILabel!
    
    private(set) var titleImage: UIImageView!
    
    private(set) var titleStack:UIStackView = UIStackView()
    
    public var textColor: UIColor = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1.0)
    public var selectedTextColor: UIColor = .white
    
    public var image: UIImage? {
        didSet {
            if let _ = titleImage {
                titleImage.image = image
                titleImage.isHidden = false
            }else{
                titleImage.image = nil
                titleImage.isHidden = true
            }
        }
    }
    public var selectedImage: UIImage? {
        didSet {
            if let _ = selectedImage {
                titleImage.highlightedImage = selectedImage
            }else{
                titleImage.highlightedImage = nil
            }
        }
    }
    
    public var isSelected: Bool = false {
        didSet {
            if let _ = titleImage {
                titleImage.isHighlighted = isSelected
            }
            if isSelected {
                titleLabel.textColor = selectedTextColor
                titleImage.isHidden = titleImage.highlightedImage == nil
            } else {
                titleLabel.textColor = textColor
                titleImage.isHidden = titleImage.image == nil
            }
        }
    }
    
    //    public override init(frame: CGRect) {
    //        super.init(frame: frame)
    //        setupLabel()
    //    }
    
    public init(frame: CGRect, imagePosition:TitleImagePosition? = .left) {
        super.init(frame: frame)
        setupLabel(imagePosition: imagePosition)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupLabel(imagePosition:TitleImagePosition? = .left) {
        titleLabel = UILabel(frame: bounds)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1.0)
        titleLabel.backgroundColor = UIColor.clear
        
        titleImage = UIImageView(frame: CGRect(x: 0, y: 0, width: bounds.size.height, height: bounds.size.height))
        titleImage.contentMode = .scaleAspectFit
        titleImage.isHidden = true;
        
        titleStack = UIStackView(arrangedSubviews: imagePosition == .left ? [titleImage,titleLabel] : [titleLabel,titleImage])
        titleStack.axis = .horizontal
        titleStack.distribution = .fill
        titleStack.alignment = .center
        titleStack.spacing = 3
        addSubview(titleStack)
        layoutLabel()
    }
    
    private func layoutLabel() {
        
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: self.topAnchor),
            titleStack.widthAnchor.constraint(equalTo: self.widthAnchor),
            titleStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }
}
