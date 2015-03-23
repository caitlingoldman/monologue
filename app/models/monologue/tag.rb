class Monologue::Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings

  validates :name, uniqueness: true, presence: true

  scope :for_published_posts, -> { published_posts_join.uniq }
  scope :max_frequency, -> { published_posts_join.group("monologue_tags.id").order("count_all ASC").count.values.max }
  scope :min_frequency, -> { published_posts_join.group("monologue_tags.id").order("count_all ASC").count.values.min }

  def posts_with_tag
    self.posts.published
  end

  def frequency
    posts_with_tag.size
  end

  private
  def self.published_posts_join
    self.joins(:posts).where(monologue_posts: { published: true }).where("monologue_posts.published_at <= ?", DateTime.now)
  end
end
