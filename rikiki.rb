# encoding: utf-8
#
# If you're using bundler, you will need to add this
require 'bundler/setup'

require 'sinatra'
require 'git'

set :public_folder, File.dirname(__FILE__) + '/static'
PAGES_LOCATION='~/Dropbox/Notes/'
PWD_FILE="#{PAGES_LOCATION}/.pwd"

# TODO : move this to a encrypted config file
def auth(username,pwd)
  File.open(File.expand_path(PWD_FILE), 'rb').each(sep='\n') do |line|
    u,p = line.chop.split(':')
    if u == username
      if Digest::MD5.hexdigest(pwd) == p
        return true
      end
    end
  end
  return false
end

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  auth(username, password)
end

get '/' do
  redirect '/wiki/index'
end

get '/search' do
  @results = []
  (Dir.glob("#{File.expand_path(PAGES_LOCATION)}/**/*").select { |s| s =~ /.md$/ }).each do |file|
    begin
      hits = File.open(file, 'r:utf-8').grep(/#{params[:search]}/i)
    rescue Exception => e
      raise "Error with file #{file}: #{e.message}"
    end
    unless hits.empty?
      page = file.gsub(/\.md$/,'').gsub(/#{File.expand_path(PAGES_LOCATION)}\//,'')
      @results += [{ page: page, hits: hits }] 
    end
  end
  haml :search_result
end

get %r{/wiki(/.*)} do |path|
  @path,@filename = filename_path(path)
  from_home=""
  @path_segments = path.split('/').drop(1).collect do |e|
    from_home += "/" + e
    {basename: e, path: from_home}
  end
  @page = @path_segments.slice!(-1)
  if @filename =~ /index\.md/
    @page[:is_a_dir] = true
  end
  @page[:content] = File.open(@filename, 'rb') { |f| f.read }
  @history = retreive_history(@filename)
  haml :main
end

post %r{/wiki(/.*)} do |path|
  @path,filename = filename_path(path)
  File.open(filename, 'w') { |f| f.write(params[:content]) }
  # git_commit(filename)
  redirect "/wiki#{@path}"
end

def filename_path(path)
  path += 'index' if path =~ /\/$/
  filename = File.expand_path "#{PAGES_LOCATION}#{path}.md"
  init_file(filename)
  [path,filename]
end

def init_file(fullpath)
  dname = File.dirname(fullpath)
  Dir.mkdir(dname) unless Dir.exists?(dname)
  File.open(fullpath, "w") {} unless File.exists?(fullpath)
end

def git_commit(fullpath)
  git_check_init
  git.add(File.expand_path(fullpath))
  git.commit(Time.now.to_s)
end

def git_check_init
  unless Dir.exists?(File.expand_path(PAGES_LOCATION+'/.git'))
    Git.init(File.expand_path(PAGES_LOCATION))
  end
end

def retreive_history(fullpath)
  git.log(10).object(File.expand_path(fullpath))
end

def git
  Git.open(File.expand_path(PAGES_LOCATION))
end

def markdown(text)
  rndr = Redcarpet::Render::HTML.new(:filter_html => true, :hard_wrap => true)
  renderer = Redcarpet::Markdown.new(rndr, :autolink => true, :fenced_code_blocks => true)
  renderer.render(text)
end

