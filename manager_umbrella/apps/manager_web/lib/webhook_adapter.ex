defmodule WebhookAdapter do
  @doc "
    Adapt to various Webhooks
  "

  def trigger_deploy(url, host, api_key) do
    @doc "
      Trigger Frontend Deploy Webhooks
    "

    body = [host: host]
    {_status, result} = JSON.encode(body)

    options = [{"X-API-KEY", api_key}, {"Content-Type", "application/json"}]

    HTTPoison.start
    HTTPoison.post!(url, result, )
  end
end
