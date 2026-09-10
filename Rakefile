desc "Build the site and check its internal links"
task :test do
  sh "bundle exec jekyll build --trace"
  sh "ruby scripts/check_site.rb _site /researcher-website"
end

task default: :test
