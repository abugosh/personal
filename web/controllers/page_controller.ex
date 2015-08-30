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

  def send_contact_request(conn, params) do
    Mailman.deliver(contact_request_email(params["name"], params["email"], params["message"]), config)

    conn
    |> put_flash(:info, "Email sent! I'll get back to you soon!")
    |> contact(params)
  end

  def config do
    %Mailman.Context{
      config:   %Mailman.SmtpConfig{
        relay: Application.get_env(:personal, Personal.Mailer)[:server],
        username: Application.get_env(:personal, Personal.Mailer)[:username],
        password: Application.get_env(:personal, Personal.Mailer)[:password],
        port: Application.get_env(:personal, Personal.Mailer)[:port],
        ssl: Application.get_env(:personal, Personal.Mailer)[:ssl],
        tls: Application.get_env(:personal, Personal.Mailer)[:tls]
      },
      composer: %Mailman.EexComposeConfig{}
    }
  end

  def contact_request_email(name, email, message) do
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
