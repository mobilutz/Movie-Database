class Movie < ActiveRecord::Base
  attr_accessible :text, :title, :category

  validates_presence_of :title
  validates_uniqueness_of :title

  has_many :ratings
  belongs_to :category

  include Tire::Model::Search
  include Tire::Model::Callbacks
  index_name INDEX_NAME unless Rails.env.development?

  def self.search(params)
    tire.search(page: params[:page], per_page: params[:per_page]) do
      query { string params[:query], default_operator: 'AND' } if params[:query].present?
      filter :term, rating_avg: params[:rating_avg] if params[:rating_avg].present?
      filter :term, category_id: params[:category_id] if params[:category_id].present?
      sort { by :created_at, 'desc'} if params[:query].blank?
      facet 'rating' do
        terms :rating_avg
      end
      facet 'category' do
        terms :category_id
      end
      # raise to_curl
    end
  end

  def rated_by?(user)
    rated = false
    ratings.each do |r|
      rated = r.user == user
      break if rated
    end
    rated
  end

  def to_indexed_json
    to_json(methods: [:rating_count, :rating_avg, :category_id, :category_name])
  end

  def rating_count
    ratings.size
  end

  def rating_avg
    ratings.average(:number).to_i
  end

  def category_id
    category.try(:id) || '-1'
  end

  def category_name
    category.try(:name)
  end
end
