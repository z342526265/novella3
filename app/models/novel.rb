class Novel < ActiveRecord::Base  
  has_many :chapters
  belongs_to :user
  belongs_to :genre
  
  has_attached_file :photo, :styles=>{:small => "150x150>"},
                    :url  => "/assets/novels/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/novels/:id/:style/:basename.:extension",
                    :default_url => "/images/empty_book.jpg"  
  
  validates_presence_of     :name, :genre_id
  validates_length_of       :description, :maximum => 255
  validates_uniqueness_of   :perma_link, :name, :case_sensitive => false
  
  #specify the number of itesm per page for will paginate
  def self.per_page
    10
  end
  
  def self.popular(genre_id, page)
    genre_clause = genre_id > 0 ? "genre_id = #{genre_id}" : ""
    paginate :page => page,
             :conditions => [genre_clause]
  end
  
  def self.recent(genre_id, page)
    genre_clause = genre_id > 0 ? "genre_id = #{genre_id}" : ""
    paginate :page => page,
             :order => 'created_at DESC',
             :conditions => [genre_clause]           
  end
  
end
