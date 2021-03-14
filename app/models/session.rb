
class Session < ApplicationRecord

  attr_accessor :name, :password

  validates :name,
    presence: true, #空白だめですよ
    uniqueness: true, #被っちゃだめですよ
    length: { maximum: 16 }, #文字数制限
    format: {
      with: /\A[a-z0-9]+\z/, #正規表現
      message: 'は小文字英数字で入力してください'
    }
  validates :password,
    length: { minimum: 8 }

    def save
      return false if invalid?
      true
    end
end
