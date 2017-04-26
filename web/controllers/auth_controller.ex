defmodule GoogleAuth.AuthController do
  use GoogleAuth.Web, :controller

  def index(conn, %{"provider" => provider}) do
    redirect conn, external: authorize_url!(provider)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(conn, %{"provider" => provider, "code" => code}) do
    client = get_token!(provider, code)
    user = get_user!(provider, client)

    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
  end

  defp authorize_url!("google"), do: Google.authorize_url!(scope: "email profile")
  defp authorize_url!("facebook"), do: Facebook.authorize_url!(scope: "public_profile email")
  
  defp authorize_url!(_), do: raise "No matching provider available"
  

  defp get_token!("google", code), do: Google.get_token!(code: code)
  defp get_token!("facebook", code), do: Facebook.get_token!(code: code)

  defp get_token!(_, _), do: raise "No matching provider available"
 

  defp get_user!("google", client) do
    user_url = "https://www.googleapis.com/plus/v1/people/me/openIdConnect"
    OAuth2.Client.get!(client, user_url).body
  end

  defp get_user!("facebook", client) do
    OAuth2.Client.get!(client, "/me", fields: "id,name,email").body
  end
end