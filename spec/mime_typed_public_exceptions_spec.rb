# frozen_string_literal: true

require 'rails_helper'

FIXTURE_LOAD_PATH = File.expand_path('fixtures', __dir__)
# for test
class ShowExceptionsController < ActionController::Base
  use ActionDispatch::ShowExceptions,
      MimeTypedPublicExceptions.new("#{FIXTURE_LOAD_PATH}/public")

  before_action do
    request.env['action_dispatch.show_detailed_exceptions'] = false
    request.env['action_dispatch.show_exceptions'] = true
  end

  def ex_404
    raise ActionController::RoutingError, 'yo'
  end

  def ex_422
    raise ActionController::InvalidAuthenticityToken
  end

  def ex_500
    raise 'boom!'
  end
end

Rails.application.configure do
  routes.draw do
    get :ex_404, to: 'show_exceptions#ex_404'
    get :ex_422, to: 'show_exceptions#ex_422'
    get :ex_500, to: 'show_exceptions#ex_500'
  end
end

describe MimeTypedPublicExceptions, type: :request do
  [
    { content_type: 'text/html', fixture_extension: 'html' },
    { content_type: 'application/json', fixture_extension: 'json' },
    { content_type: 'application/xml', fixture_extension: 'xml' }
  ].product([404, 422, 500]).each do |content, status|
    context "with #{content[:fixture_extension]} request" do
      it "return #{status}.#{content[:fixture_extension]}" do
        get "/ex_#{status}", headers: {
          'Content-Type' => content[:content_type],
          'Accept' => content[:content_type]
        }

        expect(response.body).to eq read_fixture(
          "public/#{status}.#{content[:fixture_extension]}"
        )
      end
    end
  end

  context 'with not prepared type request' do
    it 'return internal error body' do
      get '/ex_500', headers: {
        'Content-Type' => 'text/plain',
        'Accept' => 'text/plain'
      }

      expect(response.body).to eq read_fixture('public/500.html')
    end
  end
end
