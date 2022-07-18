import UIKit
import Combine

final class HomeViewController: UIViewController {

    @IBOutlet private weak var cityNameLabel: UILabel! {
        didSet {
            cityNameLabel.font = .description
            cityNameLabel.textColor = .white
        }
    }
    
    @IBOutlet private weak var weatherImageView: UIImageView! {
        didSet {
            weatherImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet private weak var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.font = .title
            temperatureLabel.textColor = .white
        }
    }
    
    @IBOutlet private weak var temperatureDescriptionLabel: UILabel! {
        didSet {
            temperatureDescriptionLabel.font = .description
            temperatureDescriptionLabel.textColor = .white
        }
    }
    
    @IBOutlet private weak var temperatureMinLabel: UILabel! {
        didSet {
            temperatureMinLabel.font = .description
            temperatureMinLabel.textColor = .white
        }
    }
    
    @IBOutlet private weak var temperatureMaxLabel: UILabel! {
        didSet {
            temperatureMaxLabel.font = .description
            temperatureMaxLabel.textColor = .white
        }
    }
    
    @IBOutlet private weak var windLabel: UILabel! {
        didSet {
            windLabel.font = .description
            windLabel.textColor = .white
        }
    }
    
    private var loadingView: LoadingView?
    
    // MARK: - Properties
    private let presenter: HomePresenterProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: HomeViewController.identifier, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureUI()
        bind()
    }
}

// MARK: - Privates
private extension HomeViewController {
    
    func bind() {
        presenter
            .loadingViewStateObservable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                
                switch state {
                case .shown:
                    guard let self = self else { return }
                    guard self.loadingView == nil else { return }
                    
                    self.loadingView = LoadingView(in: self.view)
                    
                case .hidden:
                    UIView.animate(withDuration: 0.2) {
                        self?.loadingView?.alpha = 0
                    } completion: { _ in
                        self?.loadingView?.hide()
                        self?.loadingView = nil
                    }
                }
            }
            .store(in: &cancellables)
        
        presenter
            .weatherObservable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weather in
                guard let weather = weather else { return }
                guard let self = self else { return }
                
                self.cityNameLabel.text = weather.name
                self.weatherImageView.downloadImage(iconName: weather.icon)
                self.temperatureLabel.text = weather.temperature.temp.formatTemperatureFromKelvinToCelsius()
                self.temperatureDescriptionLabel.text = weather.description
                
                self.temperatureMinLabel.text = String(format: LanguageString.low.localized,
                                                       weather.temperature.tempMin.formatTemperatureFromKelvinToCelsius())
                
                self.temperatureMaxLabel.text = String(format: LanguageString.high.localized,
                                                       weather.temperature.tempMax.formatTemperatureFromKelvinToCelsius())
                
                self.windLabel.text = String(format: LanguageString.wind.localized,
                                             "\(weather.wind.speed)",
                                             "\(weather.wind.deg)")
            }
            .store(in: &cancellables)
    }
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
    }
}
