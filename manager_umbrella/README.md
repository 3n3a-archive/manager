# Manager.Umbrella

## Important Files and Folders

* `Dockerfile`: for Deployment of Umbrella App
  * includes all deployed `apps`
* `entrypoint.sh`
  * belongs into Docker Container
  * migrates Ecto Repository on Boot
  * then starts the umbrella ☂ 
* `apps`: All the OTP-Apps
