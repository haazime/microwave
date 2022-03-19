class OauthAuthHash < SimpleDelegator
  def name
    self['info']['name']
  end

  def email
    self['info']['email']
  end

  def account
    {
      provider: self['provider'],
      uid: self['uid']
    }
  end
end
