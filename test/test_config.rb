PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require File.join(File.dirname(__FILE__),'blueprints')
require 'riot/rr'

# Specify your app using the #app helper inside a context.
# If you don't specify one, Riot::Rack will recursively look for a config.ru file.
# Takes either an app class or a block argument.
# app { Padrino.application }
# app { Omerta.tap { |app| } }

class Riot::Situation
  include Rack::Test::Methods

  # The Rack app under test.
  def app
    defined?(@app) ? @app : build_app
  end

  private

  def build_app
    config_file = File.read(find_config_file)
    Rack::Builder.new { instance_eval(config_file) }.to_app
  end

  def find_config_file
    if Dir.glob("config.ru").length > 0
      File.join(Dir.pwd,"config.ru")
    elsif Dir.pwd != "/"
      Dir.chdir("..") { find_config_file }
    else
      raise "Cannot find config.ru"
    end
  end
end

class Riot::Context
  # Set the Rack app which is to be tested.
  #
  #   context "MyApp" do
  #     app { [200, {}, "Hello!"] }
  #     setup { get '/' }
  #     asserts(:status).equals(200)
  #   end
  def app(app=nil, &block)
    setup { @app = (app || block) }
  end
end

