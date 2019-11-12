## Application deployment configuration
set :application, 'hut-team01'
set :server,      'demo1.software-hut.org.uk'
set :user,        'team01'
set :password,    '6cd156adaf28710ccd5c7b2d2aaf637a'
set :repo_url,    'git@git.software-hut.org.uk:hut-team01/project.git'

set :env_links,   %w(db/demo.sqlite3)

## Delayed Job configuration
# after 'deploy:publishing', 'deploy:restart'
# namespace :deploy do
#   task :restart do
#     invoke 'delayed_job:restart'
#   end
# end

## Server configuration
server fetch(:server), user: fetch(:user), roles: %w{web app db}, ssh_options: { forward_agent: false, auth_methods: %w(keyboard-interactive), password: fetch(:password) }
set :deploy_to,   -> { "/srv/services/#{fetch(:user)}" }
set :log_level,   :debug

## Seeding the database
task :seed do
  on primary fetch(:migration_role) do
    within release_path do
      with rails_env: fetch(:rails_env)  do
        execute :rake, 'db:seed'
      end
    end
  end
end
