require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/test_app'
require_relative '../apps/web/application'

module Foo
  def self.included(klass)
    puts 'Foo is included'
  end
end

Hanami.configure do
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/test_app_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/test_app_development'
    #    adapter :sql, 'mysql://localhost/test_app_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/test_app/mailers'

    # See https://guides.hanamirb.org/mailers/delivery
    delivery :test

    prepare do
      include Foo
    end
  end

  environment :development do
    # See: https://guides.hanamirb.org/projects/logging
    logger level: :debug

    mailer do

    end
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    end
  end
end
