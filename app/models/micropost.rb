class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) } # DBから取得時のデフォルトの並びを決める
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size # 自作のバリデーションは 複数形でない名前になっていることに注意

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
