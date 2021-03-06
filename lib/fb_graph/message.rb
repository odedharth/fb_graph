module FbGraph
  class Message < Node
    # TODO:
    # include Connections::Attachments
    # include Connections::Shares
    include Connections::Tags

    attr_accessor :subject, :message, :from, :to, :tags, :created_time

    def initialize(identifier, attributes = {})
      super
      @subject = attributes[:subject]
      @message = attributes[:message]
      if (from = attributes[:from])
        @from = User.new(from[:id], from)
      end
      @to = []
      if attributes[:to]
        Collection.new(attributes[:to]).each do |to|
          @to << User.new(to[:id], to)
        end
      end
      @tags = []
      if attributes[:tags]
        Collection.new(attributes[:tags]).each do |tag|
          @tags << Tag.new(tag)
        end
      end
      if attributes[:created_time]
        @created_time = Time.parse(attributes[:created_time]).utc
      end

      # cached connection
      @_tags_ = Collection.new(attributes[:tags])
    end
  end
end
