class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :avatar
  belongs_to :user
end
