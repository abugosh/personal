defmodule Personal.PageController do
  use Personal.Web, :controller

  @contact_form_email "contact.form@alexbugosh.com"

  def index(conn, _params) do
    render conn, "index.html"
  end

  def resume(conn, _params) do
    render conn, "resume.html"
  end

  def contact(conn, _params) do
    render conn, "contact.html"
  end

  def send_contact_request(conn, params = %{"name" => name, "email" => email, "message" => message}) do
    Mailman.deliver(contact_request_email(name, email, message), config)

    conn
    |> put_flash(:info, "Email sent! I'll get back to you soon!")
    |> contact(params)
  end

  defp config do
    mailer_config = Application.get_env(:personal, Personal.Mailer)
    %Mailman.Context{
      config: %Mailman.SmtpConfig{
        relay:    mailer_config[:server],
        username: mailer_config[:username],
        password: mailer_config[:password],
        port:     mailer_config[:port],
        ssl:      mailer_config[:ssl],
        tls:      mailer_config[:tls]},
      composer: %Mailman.EexComposeConfig{}
    }
  end

  defp contact_request_email(name, email, message) do
    %Mailman.Email{
      subject: "Website contact request from #{name}",
      from: @contact_form_email,
      to: [@contact_form_email],
      text: """
      Contact request!

      From: #{name}
      Email: #{email}

      Message:
      #{message}
      """
    }
  end
end
