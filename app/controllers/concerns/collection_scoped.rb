module CollectionScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_collection
  end

  private
    def set_collection
      @collection = Current.user.collections.find(params[:collection_id])
    end

    def cards_fresh_when(cards)
      fresh_when etag: [ cards, @collection.entropy_configuration, @collection.columns.all ]
    end
end
