require 'airbrake_tools'

$config = YAML.load_file(File.join(Dir.pwd, 'config.yml'))
AirbrakeTools.init($config['auth']['account'], $config['auth']['auth_token'])

# set utf-8 for outgoing
before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

get '/' do
  @title = 'Monitoring Airbrake'
  haml :index
end

get '/hot' do
  AirbrakeTools.hot_errors('107364').inspect
end
