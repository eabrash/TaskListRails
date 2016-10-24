class User < ActiveRecord::Base

  validates :email, :uid, :provider, presence: true
  has_many :tasks

  # def self.build_from_github(auth_hash)
  #   user       = User.new
  #   user.uid   = auth_hash[:uid]
  #   user.provider = 'github'
  #   user.name  = auth_hash['info']['name']
  #   user.email = auth_hash['info']['email']
  #
  #   return user
  # end

  def self.build_from_github_or_google(auth_hash)
    user       = User.new
    user.uid   = auth_hash[:uid]
    user.provider = auth_hash['provider']
    user.name  = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.image = auth_hash['info']['image']

    return user
  end

end
