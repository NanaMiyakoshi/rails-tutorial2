class Micropost < ApplicationRecord
  belongs_to :user
  #データベースから要素を取得したときの順序を指定するメソッドdefault_scope
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
