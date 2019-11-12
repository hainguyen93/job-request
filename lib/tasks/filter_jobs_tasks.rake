desc 'filter urgent jobs'
task filter_urgent_jobs: :environment do
  Job.filter
end
