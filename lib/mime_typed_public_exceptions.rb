# frozen_string_literal: true

require 'action_dispatch'
require 'mimemagic'

require 'mime_typed_public_exceptions/version'

# This class behaves roughly as ActionDispatch::PublicExceptions.
# PublicExceptions is a Rack::Middleware for render an error page
# which static from /public directory but html only.
# This class when called, render an error page which static
# from /public directory with not only html but also others.
class MimeTypedPublicExceptions < ActionDispatch::PublicExceptions
  private

  def render(status, content_type, _body)
    path = maybe_file_paths(status, content_type).find { |fp| File.exist?(fp) }
    if path
      render_format(status, content_type, File.read(path))
    else
      render_html(status)
    end
  end

  def maybe_file_paths(status, content_type)
    MimeMagic.new(content_type.to_s).extensions.map do |ext|
      [
        "#{public_path}/#{status}.#{I18n.locale}.#{ext}",
        "#{public_path}/#{status}.#{ext}"
      ]
    end.flatten
  end
end
