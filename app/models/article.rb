class Article < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  belongs_to :user
  
  scope :by_admin, -> { joins(:user).where('users.is_admin' => 'true') }

  def owned_by?(user_to_verify)
    user == user_to_verify
  end
end
