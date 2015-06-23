require 'trello'

module RandomIncidents
  class AddTrelloDeployCard
    COLUMN_ID_FOR_BOARD = ENV.fetch('trello_board_list_id').freeze
    MESSAGE_DESCRIPTION = 'Use the ops manual to release the app into production.'.freeze
    LIVE_APPS = ['PeopleFinder', 'Prison Visits'].freeze

    Trello.configure do |config|
      config.developer_public_key = ENV.fetch('trello_developer_public_key')
      config.member_token         = ENV.fetch('trello_token')
    end

    def add_new_deploy_card_to_board
      Trello::Card.create(card_options)
    end

    alias_method :call, :add_new_deploy_card_to_board

    private

    def card_options
      {
        list_id: COLUMN_ID_FOR_BOARD,
        name: "Please Release #{LIVE_APPS.sample}",
        desc: 'Use the ops manual to release the app into production.'
      }
    end
  end
end
