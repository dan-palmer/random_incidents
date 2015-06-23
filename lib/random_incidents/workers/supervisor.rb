require_relative '../actions/send_fake_incident_sms.rb'
require_relative '../actions/add_trello_deploy_card.rb'

module RandomIncidents
  class Supervisor < Celluloid::SupervisionGroup
    supervise RandomIncidentWorker, as: :sms_worker, args: [SendFakeIncidentSms.new]
    supervise RandomIncidentWorker, as: :trello_worker, args: [AddTrelloDeployCard.new]
  end
end
