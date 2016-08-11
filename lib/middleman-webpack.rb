# Require core library
require 'middleman-core'
require "middleman-webpack/version"

::Middleman::Extensions.register(:middleman_webpack) do
  require "middleman-webpack/extension"
  ::Middleman::WebpackExtension
end
