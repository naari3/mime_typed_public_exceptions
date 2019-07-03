# frozen_string_literal: true

require 'action_dispatch'
require 'mime_typed_public_exceptions/version'

# This class behaves roughly as ActionDispatch::PublicExceptions.
# PublicExceptions is a Rack::Middleware for render an error page
# which static from /public directory but html only.
# This class when called, render an error page which static
# from /public directory with not only html but also others.
class MimeTypedPublicExceptions < ActionDispatch::PublicExceptions
  private

  def render(status, content_type, _body)
    ext = content_type.symbol # symbol does not represent an extension
    path = [
      "#{public_path}/#{status}.#{I18n.locale}.#{ext}",
      "#{public_path}/#{status}.#{ext}"
    ].find { |fp| File.exist?(fp) }
    if path
      render_format(status, content_type, File.read(path))
    else
      render_html(status)
    end
  end
end
