namespace :git do
  desc "Place release tag into Git and push it to origin server."
  task :push_deploy_tag do
    user = `git config --get user.name`
    email = `git config --get user.email`
    tag = "release_#{release_name}"
    if exists?(:stage)
      tag = "#{stage}_#{tag}"
    end
    puts `git tag #{tag} #{revision} -m "Deployed by #{user} <#{email}>"`
    puts `git push origin tag #{tag}`
  end
end
