module Mailers
  class TestMailer
    include Hanami::Mailer

    from    '<from>'
    to      '<to>'
    subject 'Hello'
  end
end
