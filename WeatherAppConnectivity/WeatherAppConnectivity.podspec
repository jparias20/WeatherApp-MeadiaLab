Pod::Spec.new do |spec|

  spec.name         = "WeatherAppConnectivity"
  spec.version      = "1.0.0"
  spec.summary      = "This is a framework for connectivity"
  spec.description  = "This framework will contains everything related to connectivity"

  spec.homepage     = "https://github.com/jparias20/WeatherApp-MeadiaLab"
  spec.license      = "MIT"
  spec.author       = { "Jhonatan Pulgarin Arias" => "jparias0731@gmail.com" }
  spec.platform     = :ios, "15.0"
  spec.source       = { :git => "https://github.com/jparias20/WeatherApp-MeadiaLab", :tag => spec.version.to_s }
  spec.source_files  = "Library/Classes/**/*"
  spec.swift_versions = "5.0"
  
  spec.framework = "UIKit"
  
  spec.dependency "Alamofire"
  spec.dependency "AlamofireImage"

end
