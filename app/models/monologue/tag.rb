class Monologue::Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings

  validates :name, uniqueness: true, presence: true

  def posts_with_tag
    self.posts.published
  end

  def frequency
    posts_with_tag.size
  end
end
