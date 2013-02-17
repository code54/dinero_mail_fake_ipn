if ENV['DINERO_MAIL_FAKE_IPN_SCHEDULER'] == 'true'
  notification_url = ENV['DINERO_MAIL_FAKE_IPN_NOTIFICATION_URL']

  Rufus::Scheduler.start_new.every '1m' do
    ActiveRecord::Base.connection_pool.with_connection do
      # TODO: Move this to a place where I can test it.
      performed_transitions = Transition.ready.each(&:perform)
      transitions_that_need_notification = performed_transitions.find_all(&:need_notification?)
      ids = transitions_that_need_notification.map { |transition| transition.operation.client_id }.uniq

      unless ids.empty?
        notification = Notification.new(ids)
        # TODO: I'm using HTTParty just becuase some pow's issues. I didn't
        # want to spend time on them right now but I'll be happier if we can
        # remove that gem from the bundle to keep it as small as possible.
        HTTParty.post(notification_url, body: { 'Notificacion' => notification.document })
      end
    end
  end
end
