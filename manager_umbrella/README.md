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
