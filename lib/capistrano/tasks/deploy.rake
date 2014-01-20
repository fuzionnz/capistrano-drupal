namespace :deploy do
  desc <<-DESC
    Prepares one or more servers for deployment. Before you can use any \
    of the Capistrano deployment tasks with your project, you will need to \
    make sure all of your servers have been prepared with `cap deploy:setup'. When \
    you add a new server to your cluster, you can easily run the setup task \
    on just that server by specifying the HOSTS environment variable:

      $ cap HOSTS=new.server.com deploy:setup

    It is safe to run this task on servers that have already been set up; it \
    will not destroy any deployed revisions or data.
  DESC
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, releases_path, shared_path].join(' ')
    run "#{try_sudo} mkdir -p #{releases_path} #{shared_path}"
    run "#{try_sudo} chown -R #{user}:#{runner_group} #{deploy_to}"
    sub_dirs = shared_children.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{sub_dirs.join(' ')}"
    run "#{try_sudo} chmod 2775 #{sub_dirs.join(' ')}"
  end
end