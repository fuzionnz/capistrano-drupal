namespace :drupal do
  desc "Symlink settings and files to shared directory. This allows the settings.php and \
    and sites/default/files directory to be correctly linked to the shared directory on a new deployment."
  task :symlink_shared do
    ["files", "private", "settings.php"].each do |asset|
      run "rm -rf #{app_path}/#{asset} && ln -nfs #{shared_path}/#{asset} #{app_path}/sites/default/#{asset}"
    end
  end
end

