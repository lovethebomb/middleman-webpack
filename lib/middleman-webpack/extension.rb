require 'middleman-webpack/reactor'

# Extension namespace
module Middleman
  class WebpackExtension < Extension
    option :port, '25123', 'Port to bind the websocket server to listen to'
    option :host, '0.0.0.0', 'Host to bind LiveReload API server to'
    option :ignore, [], 'Array of /patterns/ for paths that must be ignored'

    def initialize(app, options_hash={}, &block)
      # Call super to build options from the options_hash
      super


      if app.respond_to?(:server?)
        return unless app.server?
      else
        return unless app.environment == :development
      end

      @reactor = nil

      options_hash = options.to_h

      extension = self

      app.ready do
        if @reactor
          @reactor.app = self
        else
          @reactor = ::Middleman::Webpack::Reactor.new(options_hash, self)
        end

        logger.debug "Middleman WS: ready"

        ignored = lambda do |file|
          return true if files.respond_to?(:ignored) && files.send(:ignored?, file)
          extension.options.ignore.any? { |i| file.to_s.match(i) }
        end

        files.changed do |file|
          next if ignored.call(file)


          reload_path = "#{Dir.pwd}/#{file}"

          file_url = sitemap.file_to_path(file)
          if file_url
            file_resource = sitemap.find_resource_by_path(file_url)
            if file_resource
              reload_path = file_resource.url
            end
          end

          logger.debug "Middleman WS: File changed - #{file}"
          @reactor.reload_browser(reload_path)
        end

        files.deleted do |file|
          next if ignored.call(file)

          logger.debug "Middleman WS: File deleted - #{file}"

          @reactor.reload_browser("#{Dir.pwd}/#{file}")
        end

      end
    end
  end
end

