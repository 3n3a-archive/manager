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

    Task.async(fn ->
          HTTPoison.start

          case HTTPoison.post(url, result, options) do
            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
              Logger.info("Webhook Sucessfully Triggered")
              Logger.debug(body)
            {:ok, %HTTPoison.Response{status_code: 404}} ->
              Logger.debug("Not found :(")
            {:error, %HTTPoison.Error{reason: reason}} ->
              Logger.error(reason)
          end
    end)
  end
end
