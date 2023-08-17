import UIKit

class ViewController: UIViewController {

    @IBOutlet var topView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchField: UISearchBar!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var arrowImageView: UIImageView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    let viewModel = ViewModel()
    var loadingAlert: UIAlertController?
    let productCellId = "ProductTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.topView.isHidden = true
        configureTableView()
        topViewUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchDataAndShowLoadingIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Customize navigation bar appearance
        navigationController?.navigationBar.barTintColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    private func topViewUI() {
        
        searchField.barTintColor = .white
        searchField.layer.cornerRadius = 5
        searchField.clipsToBounds = true
        // Create gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = topView.bounds
        
        let startColor = UIColor.blue.cgColor
        let endColor = UIColor.purple.cgColor
        gradientLayer.colors = [startColor, endColor]
        
        gradientLayer.locations = [0.0, 1.0]
        
        topView.layer.insertSublayer(gradientLayer, at: 0)
    }
    private func configureTableView() {
        tableView.dataSource = self
        // Register cell
        tableView.register(UINib.init(nibName: productCellId, bundle: nil), forCellReuseIdentifier: productCellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
        
    }
    
    private func fetchDataAndShowLoadingIndicator() {
        loadingAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        
        loadingAlert?.view.addSubview(loadingIndicator)
        present(loadingAlert!, animated: true, completion: nil)
        
        viewModel.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.loadingAlert?.dismiss(animated: true) {
                    self?.topView.isHidden = false
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var totalRowCount = 0
               for item in viewModel.items {
                   totalRowCount += item.result.count
               }
               return totalRowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: productCellId, for: indexPath) as! ProductTableViewCell
        var resultIndex = 0
        for item in viewModel.items {
            if indexPath.row < resultIndex + item.result.count {
                let result = item.result[indexPath.row - resultIndex]
                cell.configure(with: result)
                break
            }
            resultIndex += item.result.count
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let minimumCellHeight: CGFloat = 100.0 // Set your desired minimum cell height here
        return max(minimumCellHeight, UITableView.automaticDimension)
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
