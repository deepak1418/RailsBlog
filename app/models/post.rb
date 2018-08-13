# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  title            :string
#  body             :text
#  description      :text
#  slug             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  banner_image_url :string
#  author_id        :integer
#  published        :boolean          default(FALSE)
#  published_at     :datetime
#

class Post < ApplicationRecord
  acts_as_taggable # Alias for acts_as_taggable_on :tags

  extend FriendlyId
  friendly_id :title, use: :slugged
  scope :most_recent, -> { order(published_at: :desc) }
  scope :published, -> {where(published: true)}
  scope :recent_paginate, -> (page) {most_recent.paginate(page: page, :per_page => 6) }
  scope :with_tage,->(tag){tagged_with(tag) if tag.present?}

  scope :list_for, ->(page,tag) do
      @posts = recent_paginate(page).with_tage(tag)
  end

  belongs_to :author, optional: true, dependent:   :destroy

  def should_generate_new_friendly_id?
     title_changed?
  end
  def display_day
    if published_at.present?
   "Published #{published_at.strftime('%-b %-d,%Y')}"
    else
      "Not published Yet."
      end
  end
  end

