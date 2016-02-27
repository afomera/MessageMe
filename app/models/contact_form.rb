class ContactForm < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true
  attribute :nickname,  :captcha  => true

  def headers
    {
      :subject => "Contact Form Submission on tmsg.io",
      :to => Rails.application.secrets.admin_email_address,
      :from => %("#{name}" <#{email}>)
    }
  end
end
