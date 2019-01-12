# frozen_string_literal: true

namespace :deploy do
  desc "Restart application"
  task :restart do
    on roles(:all) do |_host|
      # this will restart passenger server
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end
end
