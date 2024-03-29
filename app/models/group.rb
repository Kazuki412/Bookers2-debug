class Group < ApplicationRecord
  has_one_attached :group_image

  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: "User"
  has_many :users, through: :group_users

  validates :name, presence: true
  validates :introduction, presence: true

  def is_owned_by?(user)
    owner.id == user.id
  end

  def include_user?(user)
    group_users.exists?(user_id: user.id)
  end

  def get_group_image
    (group_image.attached?) ? group_image: 'no_image.jpg'
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @group = Group.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @group = Group.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @group = Group.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @group = Group.where("name LIKE?","%#{word}%")
    else
      @group = Group.all
    end
  end
end
