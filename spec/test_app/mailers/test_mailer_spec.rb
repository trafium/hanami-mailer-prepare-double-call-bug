RSpec.describe Mailers::TestMailer, type: :mailer do
  it 'delivers email' do
    mail = Mailers::TestMailer.deliver
  end
end
