# A sample Guardfile
# More info at https://github.com/guard/guard#readme
#

guard :coffeescript, :input => 'static/js'

guard :sass,  :input => "static/css"

guard 'pow' do
  watch('.powrc')
  watch('.powenv')
  watch('.rvmrc')
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('rikiki.rb')
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.*\.rb$})
  watch(%r{^config/initializers/.*\.rb$})
end
