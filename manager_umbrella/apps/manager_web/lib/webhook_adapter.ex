defmodule WebhookAdapter do
  @doc "
    Adapt to various Webhooks
  "

  def trigger_deploy(part) do
    @doc "
      Trigger Frontend Deploy Webhooks
    "

    url = System.get_env("WEBHOOK_API")
    api_key = System.get_env("WEBHOOK_KEY")

    body = [part: part]
    {_status, result} = JSON.encode(body)

    options = [{"X-API-KEY", api_key}, {"Content-Type", "application/json"}]

    HTTPoison.start
    HTTPoison.post!(url, result, options)
  end
end
