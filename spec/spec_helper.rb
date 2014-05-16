# -*- coding: utf-8 -*-
require "bundler"
Bundler.setup(:default)
require 'mongoid'
ENV['RACK_ENV'] = 'test'
Mongoid.load!(File.expand_path("../mongoid.yml",__FILE__))

require "./lib/knowledge-net-store"
Bundler.require(:test)

RSpec.configure do |config|

  config.before :each do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner[:mongoid].start
  end

  config.after :each do
    DatabaseCleaner[:mongoid].clean
  end
end
