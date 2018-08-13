# == Schema Information
#
# Table name: authors
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Author < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable,:timeoutable,
         :recoverable, :rememberable,:registerable, :trackable, :validatable

  has_many :posts
  has_many :active_relationships, class_name:  "Relationship",
           foreign_key: "follower_id",
           dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
           foreign_key: "followed_id",
           dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


  validates_uniqueness_of :name,on: :create

  validates_presence_of :name, on: :update
  # validates_presence_of :avatar, on: :update

  def change_password(attr)
     update(password: attr[:new_password],password_confirmation: attr[:new_password_confirmation])
  end



  def follow(other_author)
    following << other_author
  end

  # Unfollows a user.
  def unfollow(other_author)
    following.delete(other_author)
  end

  # Returns true if the current user is following the other user.
  def following?(other_author)
    following.include?(other_author)
  end


end
