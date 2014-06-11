class AdminAuthorization
  def self.matches?(request)
    current_user = request.env['warden'].user
    current_user && current_user.admin == true
  end
end
