# frozen_string_literal: true
class Service::Notification
  APP_NAME = 'UProgress'
  attr_accessor :user, :fcm

  def initialize(user)
    @user = user
    client_options = {
      apiKey: 'AIzaSyAMvPuFxr8rPsVYSKiIEJ9nUJvT7H9YEXg',
      authDomain: 'uprogress-a0a8d.firebaseapp.com',
      databaseURL: 'https://uprogress-a0a8d.firebaseio.com',
      storageBucket: 'uprogress-a0a8d.appspot.com',
      messagingSenderId: '879658458834'
    }
    @fcm = FCM.new(ENV['FIREBASE_API_KEY'], client_options)
  end

  def send_android_notification
    options = { title: 'title', sound: 'default', body: 'Test body' }
    fcm.send_notification(user.authorizations.android_device_tokens, options)
  end
end
