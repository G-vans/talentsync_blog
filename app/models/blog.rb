class Blog < ApplicationRecord
    validates :title, :content, :author, presence: true
end
