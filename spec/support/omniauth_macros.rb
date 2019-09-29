module OmniauthMacros
  def line_mock(user)
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      {
        provider: "line",
        uid: "12345",
        info: {
          name: user
        }
        credentials: {
          token: "hogefuga"
        }
      }
    )
  end
end
