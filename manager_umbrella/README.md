# Manager.Umbrella

## Important Files and Folders

* `Dockerfile`: for Deployment of Umbrella App
  * includes all deployed `apps`
* `entrypoint.sh`
  * belongs into Docker Container
  * migrates Ecto Repository on Boot
  * then starts the umbrella ☂ 
* `apps/`: All the OTP-Apps
* `config/`: Config for stages
  * when adding new app, make sure you add:
    * config to `prod.exs`
    * config to `runtime.exs`
    * config to `config.exs`


## Webhook Api Spec

### Receives from Manager

**Header**

* `X-API-KEY`, with a respective Key

**Body**

```json
{part: "school"}
```

### Implementation

* hardcoded Api Keys
* public URL
* hardcoded Array of objects
  * with `{part: "school", url: "https://webhook"}`
* to get url for **part** do some array filtering
