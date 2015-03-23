FactoryGirl.define do
  factory :tag, class: Monologue::Tag do
    sequence(:name) { |n| "Tag #{n}" }
  end

  factory :tag_with_post, class: Monologue::Tag, parent: :tag do |tag|
    tag.after_create do |tag|
      tag.posts << Factory(:post)
    end
  end
end