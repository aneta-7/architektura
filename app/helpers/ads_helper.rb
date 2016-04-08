module AdsHelper
  # Returns the Gravatar for the given user.
  def avatar_url(ad,size)
    gravatar_id = Digest::MD5.hexdigest(ad.name)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
