import Foundation
import UIKit
import ViewCode
import Components
import Resources

final class LoginView: UIViewController {
    
    private var viewModel: LoginViewDelegate?
    
    private let loginTitle = "Ja sou cliente"
    private let registerTitle = "Quero fazer parte!"
    private let mainTitle = "Conta Digital PJ"
    private let secondTitle = "Poderosamente simples"
    private let labelDescription = "Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos."
    
    private lazy var cover: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = Colors.pink
        return view
    }()
    
    private lazy var logo: UIImageView = {
        let view: UIImageView = UIImageView(image: UIImage(imageLiteralResourceName: Images.logo))
        return view
    }()
    
    private lazy var person: UIImageView = {
        let view: UIImageView = UIImageView(image: UIImage(imageLiteralResourceName: Images.eduardo))
        return view
    }()
    
    private lazy var personLeftMask: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.backgroundColor = Colors.pink
        return view
    }()
    
    private lazy var personRaightMask: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.backgroundColor = Colors.pink
        return view
    }()
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = Dimensions.small
        return stack
    }()
    
    private lazy var coverStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = Dimensions.tiny
        return stack
    }()
    
    private lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = mainTitle
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: Dimensions.fontLarge, weight: .bold)
        return label
    }()
    
    private lazy var secondTitleLabel: UILabel = {
        let label = UILabel()
        label.text = secondTitle
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: Dimensions.fontLarge)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = labelDescription
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: Dimensions.fontSmall)
        return label
    }()
    
    private lazy var loginButton: RegularButton = {
        let button = RegularButton()
        button.set(title: loginTitle, alignment: .center, style: .pink)
        button.addTarget(self, action: #selector(loginActionCallback), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: RegularButton = {
        let button = RegularButton()
        button.set(title: registerTitle, alignment: .left, style: .white)
        button.addTarget(self, action: #selector(registerActionCallback), for: .touchUpInside)
        return button
    }()
    
    required init?(coder: NSCoder) { return nil }
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    @objc
    private func loginActionCallback() {
        loginButton.flash()
        viewModel?.login()
    }
    
    @objc
    private func registerActionCallback() {
        registerButton.flash()
        viewModel?.register()
    }
}

extension LoginView: ViewCode {
    func setSubviews() {
        view.addSubviews([coverStack, stack, logo])
        coverStack.addArrangedSubview(person)
        coverStack.addArrangedSubview(cover)
        //person.addSubviews([personLeftMask, personRaightMask])
        stack.addArrangedSubview(UIView(frame: .zero))
        stack.addArrangedSubview(titleStack)
        stack.addArrangedSubview(descriptionLabel)
        stack.addArrangedSubview(Spacer(size: Dimensions.verySmall))
        stack.addArrangedSubview(registerButton)
        stack.addArrangedSubview(loginButton)
        titleStack.addArrangedSubview(mainTitleLabel)
        titleStack.addArrangedSubview(secondTitleLabel)
    }
    
    func setConstraints() {
        coverStack.setAnchorsEqual(to: view)
        logo.anchor(top: view.topAnchor,
                    leading: view.leadingAnchor,
                    paddingTop: Dimensions.medium,
                    paddingLeft: Dimensions.medium)
        logo.size(height: 22.5,width: 90)
        person.setWidthEqual(to: view)
        person.size(height: 320)
        cover.setWidthEqual(to: coverStack)
        stack.anchor(top: view.topAnchor,
                     leading: view.leadingAnchor,
                     bottom: view.bottomAnchor,
                     trailing: view.trailingAnchor,
                     paddingBottom: Dimensions.small,
                     paddingLeft: Dimensions.medium,
                     paddingRight: Dimensions.medium)
        
        titleStack.setWidthEqual(to: stack)
        mainTitleLabel.setWidthEqual(to: titleStack)
        secondTitleLabel.setWidthEqual(to: titleStack)
        
        descriptionLabel.setWidthEqual(to: stack)
        loginButton.size(height: Dimensions.large)
        loginButton.setWidthEqual(to: stack)
        registerButton.size(height: Dimensions.veryLarge)
        registerButton.setWidthEqual(to: stack)
    }
}

extension LoginView: LoginViewProtocol {
    func set(delegate: LoginViewDelegate) {
        self.viewModel = delegate
    }
}
