# A sample Gemfile
source "https://rubygems.org"

#iOS
gem 'bundler', '= 2.1.4'
gem 'cocoapods', '= 1.8.4'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
