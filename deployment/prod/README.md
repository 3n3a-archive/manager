# Production Deployment

## Things to Remember

* Add all Environment Variables
  * `WEBHOOK_URL` & `WEBHOOK_KEY` not configured by default
* Create new deployment on PROD Server and Test
* Set Environment Variables
  * URL in `WEBHOOK_URL` should end with `/api/trigger`
