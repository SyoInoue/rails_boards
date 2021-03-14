# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  body       :text(65535)
#  name       :string(255)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Board < ApplicationRecord
  has_many :comments, dependent: :delete_all #主キー
  has_many :board_tag_relations, dependent: :delete_all #delete_all削除する際に関連するオブジェクトも全て削除
  has_many :tags, through: :board_tag_relations

  validates :name, presence: true, length: { maximum: 10 } #バリデーション。
  validates :title, presence:true, length: { maximum: 30 } #オブジェクトがDBに保存される前に、
  validates :body, presence: true, length: { maximum: 1000 }#そのデータが正しいかどうかを検証する仕組み
  #presenceはnullかどうか。lengthは最大文字数
end
