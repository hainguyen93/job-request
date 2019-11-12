  ## Application configuration
set :application,       'job_request_system'
set :scm,               :git
set :repo_url,          'git@git.software-hut.org.uk:hut-teamX/project.git'
set :linked_files,      fetch(:linked_files, []).push('db/demo.sqlite3', 'config/database.yml', 'config/secrets.yml')
set :linked_dirs,       fetch(:linked_dirs,   []).push('uploads', 'tmp/pids')

## Ruby configuration
set :rvm_type,          :system
set :rvm_ruby_version,  'ruby-2.0.0-p576'

## Capistrano configuration
set :log_level,         :info
set :pty,               true
set :keep_releases,     2

## Whenever configuration
set :whenever_command,        [:bundle, :exec, :whenever]
set :whenever_roles,          [:db]
set :whenever_environment,    -> { (fetch(:rails_env) || fetch(:stage)) }
set :whenever_identifier,     -> { "#{fetch(:application)}-#{fetch(:whenever_environment)}" }
set :whenever_variables,      -> { "\"environment=#{fetch(:whenever_environment)}&delayed_job_args_p=#{fetch(:delayed_job_args_p)}&delayed_job_args_n=#{fetch(:delayed_job_args_n)}\"" }

## Delayed Job configuration
set :delayed_job_args_p,      -> { fetch(:whenever_identifier) }
set :delayed_job_args_n,      '1'
set :delayed_job_args,        -> { "-p #{fetch(:delayed_job_args_p)} -n #{fetch(:delayed_job_args_n)}" }
set :delayed_job_server_role, :db

namespace :delayed_job do

  def args
    fetch(:delayed_job_args, '')
  end

  def delayed_job_roles
    fetch(:delayed_job_server_role, :app)
  end

  desc 'Stop the delayed_job process'
  task :stop do
    on roles(delayed_job_roles) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :'bin/delayed_job', :stop
        end
      end
    end
  end

  desc 'Start the delayed_job process'
  task :start do
    on roles(delayed_job_roles) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :'bin/delayed_job', args, :start
        end
      end
    end
  end

  desc 'Restart the delayed_job process'
  task :restart do
    on roles(delayed_job_roles) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :'bin/delayed_job', args, :restart
        end
      end
    end
  end

end

## Fix the Gemfile.lock file if deploying from Windows
namespace :deploy do

  after :updating, :fix_bundler do
    on roles(:app) do
      within release_path do
        ## Remove any platform specific version strings
        execute :sed, '-ie', "'s/-x86-mingw32//'", 'Gemfile.lock'
        execute :sed, '-ie', "'s/-x64-mingw32//'", 'Gemfile.lock'

        ## This might be required if it doesn't like the mingw32 platform
        # execute :sed, '-ie', "'s/x(86|64)-mingw32/ruby/'", 'Gemfile.lock'
      end
    end
  end

end
