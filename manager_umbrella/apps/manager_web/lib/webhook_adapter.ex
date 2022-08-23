defmodule WebhookAdapter do
  @doc "
    Adapt to various Webhooks
  "

  require Logger

  def trigger_deploy(part) do

    url = System.get_env("WEBHOOK_URL", "please_configure_url")
    api_key = System.get_env("WEBHOOK_KEY", "please_configure_key")

    body = %{"part" => part, "key" => api_key}
    result = Jason.encode!(body)

    options = [{"Content-Type", "application/json"}]

    HTTPoison.start
    {:ok, response} = HTTPoison.post!(url, result, options)
    Logger.debug(response)
  end
end
