class Message < ApplicationRecord
    after_save :notify_subscribers

    private
    def notify_subscribers
        TestSchema.subscriptions.trigger("newMessage", {}, self)
    end
end
