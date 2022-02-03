class ContactMailer < ApplicationMailer

  # def send_mail(mail_title,mail_content,group_users) #メソッドに対して引数を設定
  #   @mail_title = mail_title
  #   @mail_content = mail_content
  #   mail bcc: group_users.pluck(:email), subject: mail_title
  # end
  
  def send_notification(member, event)
    @group = event[:group]
    @title = event[:title]
    @body = event[:body]
    
    @mail = ContactMailer.new()
    mail(
      from: ENV['KEY'],
      to:   member.email,
      subject: 'New Event Notice!!'
    )
  end
  
  def self.send_notifications_to_group(event)
    group = event[:group]
    group.users.each do |member|
      ContactMailer.send_notification(member, event).deliver_now
    end
  end
  
end
