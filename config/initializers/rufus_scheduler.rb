if ENV['DINERO_MAIL_FAKE_IPN_SCHEDULER'] = 'true'
  Rufus::Scheduler.start_new.every '1m' do
    Transition.ready.each(&:perform)
  end
end
