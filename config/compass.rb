require 'sass'
require 'compass'

http_path = "/"
css_dir = "build"
sass_dir = "src"
output_style = (environment == :production) ? :compressed : :expanded
