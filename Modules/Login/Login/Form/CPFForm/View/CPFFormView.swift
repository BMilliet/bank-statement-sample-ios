import Foundation
import UIKit
import ViewCode
import Components

final class CPFFormView: UIViewController {
    
    private var viewModel: CPFFormViewDelegate?
    
    private let navTitle = "Login Cora"
    private let welcome  = "Bem-vindo de volta!"
    private let buttonTitle = "Próximo"
    private let titleLabelString = "Qual seu CPF?"
    
    private lazy var backGround: UIView = UIView(frame: .zero)
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = Dimensions.verySmall
        return stack
    }()
    
    private lazy var stackEmbedded: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = Dimensions.verySmall
        return stack
    }()
    
    private lazy var footerStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var navigation: NavigationBar = {
        let nav = NavigationBar(title: navTitle)
        nav.set(delegate: self)
        return nav
    }()

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = welcome
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontSmall)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleLabelString
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Dimensions.fontMedium, weight: .bold)
        return label
    }()
    
    private let textField: UITextField = {
        let text = UITextField(frame: .zero)
        text.keyboardType = .numberPad
        return text
    }()

    private lazy var keyBoardSize: NSLayoutConstraint? = NSLayoutConstraint(item: keyboardHolder,
                                                                            attribute: .height,
                                                                            relatedBy: .equal,
                                                                            toItem: nil,
                                                                            attribute: .height,
                                                                            multiplier: 1,
                                                                            constant: view.frame.height/3.2)
    
    private lazy var nextButton: RegularButton = {
        let button = RegularButton()
        button.set(title: buttonTitle, alignment: .left, style: .pink, icon: .arrow)
        button.addTarget(self, action: #selector(nextActionCallback), for: .touchUpInside)
        return button
    }()
    
    private lazy var keyboardHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) { return nil }
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    @objc
    private func nextActionCallback() {
        nextButton.flash()
        nextWithInput(input: textField.text ?? "")
    }
    
    @objc
    private func keyboardWillShow() {
        keyBoardSize?.isActive = true
    }
    
    @objc
    private func keyboardWillHide() {
        keyBoardSize?.isActive = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.text = ""
        textField.becomeFirstResponder()
        changeButtonStatus(.disabled)
    }
}

extension CPFFormView: ViewCode {
    func setSubviews() {
        view.addSubviews([backGround, stack, footerStack])
        stack.addArrangedSubview(navigation)
        stack.addArrangedSubview(Spacer(size: Dimensions.small))
        stack.addArrangedSubview(stackEmbedded)
        stackEmbedded.addArrangedSubview(welcomeLabel)
        stackEmbedded.addArrangedSubview(titleLabel)
        stackEmbedded.addArrangedSubview(Spacer(size: Dimensions.verySmall))
        stackEmbedded.addArrangedSubview(textField)
        footerStack.addArrangedSubview(nextButton)
        footerStack.addArrangedSubview(keyboardHolder)
    }
    
    func setConstraints() {
        navigation.setWidthEqual(to: stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     leading: view.leadingAnchor,
                     trailing: view.trailingAnchor)
        
        backGround.setWidthEqual(to: view)
        backGround.anchor(top: stack.topAnchor, bottom: view.bottomAnchor)
        
        stackEmbedded.anchor(leading: stack.leadingAnchor,
                             trailing: stack.trailingAnchor,
                             paddingLeft: Dimensions.medium,
                             paddingRight: Dimensions.medium)
        
        welcomeLabel.setWidthEqual(to: stack)
        titleLabel.setWidthEqual(to: stack)
        
        textField.size(height: 32)
        textField.setWidthEqual(to: stackEmbedded)
        
        nextButton.size(height: 50)
        nextButton.setWidthEqual(to: footerStack)
        footerStack.anchor(leading: view.leadingAnchor,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           trailing: view.trailingAnchor,
                           paddingBottom: Dimensions.mediumSmall,
                           paddingLeft: Dimensions.medium,
                           paddingRight: Dimensions.medium)
        
        if let constraint = keyBoardSize {
            keyboardHolder.addConstraints([constraint])
            keyBoardSize?.isActive = false
        }
    }
    
    func extraSetups() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        textField.addTarget(self, action: #selector(inputValue), for: .editingChanged)
        
        nextButton.state(.disabled)
        
        backGround.backgroundColor = Colors.white
        view.backgroundColor = Colors.lightGray
    }
    
    
    @objc
    func inputValue() {
        (String(textField.text ?? "").isEmpty) ?
        changeButtonStatus(.disabled) :
        changeButtonStatus(.enabled)
    }
}

extension CPFFormView: CPFFormViewProtocol {
    func nextWithInput(input: String) {
        viewModel?.inputCPF(input)
    }
    
    func changeButtonStatus(_ value: ButtonState) {
        nextButton.state(value)
    }
    
    func set(delegate: CPFFormViewDelegate) {
        self.viewModel = delegate
    }
    
    func goBack() {
        viewModel?.tapBack()
    }
}

extension CPFFormView: NavigationBarDelegate {
    func tapBack(){
        goBack()
    }
    
    func tapShare() {}
}
