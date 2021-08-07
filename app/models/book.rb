class Book < ApplicationRecord
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
	belongs_to :user

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

  def self.looks(searchs, words)
    if searchs == "perfect_match"
      @books = Book.where("title LIKE ?", "#{words}")
    elsif searchs == "partial_match"
      @books = Book.where("title LIKE ?", "%#{words}%")
    elsif searchs == "forward_match"
      @books = Book.where("title LIKE ?", "#{words}%")
    elsif searchs == "rear_match"
      @books = Book.where("title LIKE ?", "%#{words}")
    end
  end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #今週
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } # 前週

end