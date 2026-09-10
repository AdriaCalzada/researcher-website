# frozen_string_literal: true

require "nokogiri"
require "pathname"

site_dir = Pathname(ARGV.fetch(0, "_site")).expand_path
baseurl = ARGV.fetch(1, "")
html_files = Dir[site_dir.join("**/*.html")]
errors = []

html_files.each do |filename|
  document = Nokogiri::HTML5(File.read(filename))
  ids = document.css("[id]").map { |node| node["id"] }
  duplicates = ids.tally.select { |_id, count| count > 1 }.keys
  errors << "#{filename}: duplicate ids: #{duplicates.join(', ')}" unless duplicates.empty?

  document.css("img:not([alt])").each do |image|
    errors << "#{filename}: image is missing alt text (#{image['src']})"
  end

  document.css('a[target="_blank"]').each do |link|
    rel = link["rel"].to_s.split
    errors << "#{filename}: external link is missing rel=noopener (#{link['href']})" unless rel.include?("noopener")
  end

  document.css("[href], [src]").each do |node|
    reference = node["href"] || node["src"]
    next if reference.nil? || reference.empty? || reference.start_with?("mailto:", "tel:", "data:")
    next if reference.match?(%r{\A(?:https?:)?//})

    if reference.start_with?("#")
      anchor = reference.delete_prefix("#")
      errors << "#{filename}: missing anchor #{reference}" unless ids.include?(anchor)
      next
    end

    path = reference.split(/[?#]/, 2).first
    path = path.delete_prefix(baseurl) unless baseurl.empty?
    target = if path.start_with?("/")
               site_dir.join(path.delete_prefix("/"))
             else
               Pathname(filename).dirname.join(path)
             end

    target = target.join("index.html") if target.directory?
    errors << "#{filename}: missing local asset #{reference}" unless target.exist?
  end
end

if errors.empty?
  puts "Checked #{html_files.length} HTML files: links, anchors, IDs and image text are valid."
else
  warn errors.join("\n")
  exit 1
end
