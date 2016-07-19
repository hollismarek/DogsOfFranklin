class ContactController < ApplicationController
  require 'rest-client'

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new user_params
    #RestClient.post "https://#{ENV['MAILGUN_API_KEY']}"\
    #{}"@api.mailgun.net/v3/#{ENV['MAILGUN_DOMAIN']}/messages",
    #:from => "Dogs Of Franklin <mailgun@#{ENV['MAILGUN_DOMAIN']}>",
    #:to => "ENV['MAILGUN_FROM'], admin@#{ENV['MAILGUN_DOMAIN']}",
    #:subject => "Message From Contact Form",
    #:text => "Message From #{@contact.name} <#{@contact.email}>\r\n #{@contact.content}"
    send_message "Message From #{@contact.name} <#{@contact.email}>\r\n #{@contact.content}"
    redirect_to '/'
  end

  private def user_params
    params.require(:contact).permit(:name, :email, :content)
  end

  def send_message (msg)
    RestClient.post "https://api:#{ENV['MAILGUN_API_KEY']}@api.mailgun.net/v3/#{ENV['MAILGUN_DOMAIN']}/messages",
    from: "Dogs Of Franklin <mailgun@#{ENV['MAILGUN_DOMAIN']}>",
    to: "#{ENV['MAILGUN_TO']}, admin@#{ENV['MAILGUN_DOMAIN']}",
    subject: "Contact Form Submission",
    text: msg
  end

  def send_simple_message (msg)
  RestClient.post "https://api:key-1d87d8999ba073aabaa84a04914ab773"\
  "@api.mailgun.net/v3/mg.greathallweb.com/messages",
  :from => "Excited User <mailgun@mg.greathallweb.com>",
  :to => "hmarek@cafemarek.com, hollis@mg.greathallweb.com",
  :subject => "Hello",
  :text => msg
  end
end
