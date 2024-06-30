require 'html-proofer'

namespace :html do
  desc "Run HTML-Proofer on the generated site"
  task :proofer do
    options = {
      assume_extension: true,
      check_html: true,
      disable_external: true
    }
    HTMLProofer.check_directory("public", options).run
  end
end
