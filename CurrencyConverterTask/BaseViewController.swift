


class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.edgesForExtendedLayout = UIRectEdge()
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "back", style: .plain, target: self, action: #selector(onBackTapped))
    }
    
    override func loadView() {
        self.view = self.createView()
    }
    
    func createView() -> UIView {
        let viewName = String(describing: self.classForCoder).replacingOccurrences(of: "Controller", with: "")
        let object = NSStringFromClass(BaseViewController) as NSString
        let module = object.components(separatedBy: ".").first!
        let className = "\(module).\(viewName)"
        let classFromName = NSClassFromString(className) as! UIView.Type
        return classFromName.init(frame: self.getFrame())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isRootViewControllerInNavigation() {
            self.createLeftBarButtonItem("Close")
        }
        if self.getView().isKind(of: BaseView.self) {
            (self.getView() as! BaseView).viewWillAppear(animated: animated)
        } else if self.getView().isKind(of: BaseSteviaView.self) {
            (self.getView() as! BaseSteviaView).viewWillAppear(animated: animated)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.getView().isKind(of: BaseView.self) {
            (self.getView() as! BaseView).viewDidAppear(animated: animated)
        } else if self.getView().isKind(of: BaseSteviaView.self) {
            (self.getView() as! BaseSteviaView).viewDidAppear(animated: animated)
        }
    }
    
    func getView() -> UIView {
        return self.view
    }
    
    func getFrame() -> CGRect {
        return UIScreen.main.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func onBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// Left, Right bar buttons
extension BaseViewController {
    func createLeftBarButtonItem(_ title: String) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(onLeftBarButtonItemTapped))
    }
    
    func createRightBarButtonItem(_ title: String) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(onRightBarButtonItemTapped))
    }
    
    func onLeftBarButtonItemTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func onRightBarButtonItemTapped() { }
}
