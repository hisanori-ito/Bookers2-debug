class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'

  has_many :view_counts, dependent: :destroy

  scope :posted_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :posted_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :posted_this_week, -> { to = Time.current.at_beginning_of_day,
                                from = (to - 1.week),
                                where(created_at: from...to )}
  scope :posted_last_week, -> { to = 1.week.ago,
                                from = (to - 2.week),
                                where(created_at: from...to )}

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    # favorites.exists?(user_id: user.id)
    favorites.where(user_id: user.id).exists?
  end

  # ↓多分when caseでもかける
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end

  # def self.last_week
  #   Book.joins(:favorites).where(favorites: { created_at:0.days.ago.last_week..0.days.ago.last_week(:sunday)}).group(:id).order("count_all desc").count
  # end

end