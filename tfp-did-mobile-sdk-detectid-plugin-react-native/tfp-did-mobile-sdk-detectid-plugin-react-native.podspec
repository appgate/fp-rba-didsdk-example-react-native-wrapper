require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "tfp-did-mobile-sdk-detectid-plugin-react-native"
  s.version      = package["version"]
  s.summary      = "DID Library"
  s.license      = "Private"

  s.authors      = "Appgate"
  s.homepage     = "https://www.appgate.com/"
  s.platform     = :ios, "11.0"

  s.source = { :git => '' }
  s.source_files  = "ios/didbridge/**/*.{h,m,swift}", "ios/DIDReact-Bridging-Header.h"

  s.vendored_frameworks = 'ios/libs/appgate_core.xcframework', 'ios/libs/appgate_sdk.xcframework', 'ios/libs/didm_core.xcframework', 'ios/libs/didm_sdk.xcframework'

  s.dependency 'React-Core'
end
