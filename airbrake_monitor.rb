require 'airbrake_tools'
require 'ostruct'

$config = YAML.load_file(File.join(Dir.pwd, 'config.yml'))
AirbrakeTools.init($config['auth']['account'], $config['auth']['auth_token'])

$projects = AirbrakeTools.airbrake_projects

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
  if params[:project_id].nil?
      return haml :projects
  end
  @project = $projects.select{|v| v[:id]==params[:project_id]}[0]
  if @project.nil?
      @error_message = "Project doesn't exist!"
      return haml :error
  end
  @errors = AirbrakeTools.hot({:project_id => @project.id})
  haml :list
end

get '/search' do
  if params[:search_text].nil?
      return haml :index
  end
  @search_text = params[:search_text]
  @title = "Find \"#{@search_text}\""
  if params[:project_id].nil?
      return haml :projects
  end
  @project = $projects.select{|v| v[:id]==params[:project_id]}[0]
  if @project.nil?
      @error_message = "Project doesn't exist!"
      return haml :error
  end
  @errors = AirbrakeTools.all_errors({:project_id => @project.id, :pages => 1})
  puts @errors
  @errors = @errors.select{|e| e.inspect.include? @search_text}
  haml :list
end
