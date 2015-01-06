require 'airbrake_tools'
require 'ostruct'

$config = YAML.load_file(File.join(Dir.pwd, 'config.yml'))
AirbrakeTools.init($config['auth']['account'], $config['auth']['auth_token'])

$projects = []
$projects_hash = {}
$config['project_names'].zip($config['project_ids']).each do |name, id|
  project = OpenStruct.new
  project.name = name
  project.id = id
  $projects.push(project)
  $projects_hash[id] = name
end

# set utf-8 for outgoing
before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

get '/' do
  @title = 'Monitoring Airbrake'
  haml :index
end

get '/hot' do
  @title = 'Hot Errors'
  @projectid = params[:projectid]
  @project_name = $projects_hash[@projectid]
  if @projectid.nil?
      return haml :projects
  end
  @errors = AirbrakeTools.hot_errors(@projectid)
  haml :list
end
