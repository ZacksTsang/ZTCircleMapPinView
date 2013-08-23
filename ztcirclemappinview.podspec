Pod::Spec.new do |s|
  s.name     = 'OCMapView'
  s.version  = '0.01'
  s.platform = :ios
  s.summary  = 'show the map pin view to center view what inspired by CityGuide.'
  s.homepage = 'https://github.com/ZacksTsang/ZTCircleMapPinView'
  s.author   = { 'zackstsang' => 'zshaojia@gmail.com' }
  s.source   = { :git => 'https://github.com/ZacksTsang/ZTCircleMapPinView.git', :tag => '0.01' }

  s.description = 'show the map pin view to center view what inspired by CityGuide.'
  s.requires_arc = true
  s.source_files = 'ZTCircleMapPinView'
  s.frameworks   = 'MapKit', 'QuartzCore'
  s.license = "LICENSE.txt"
end