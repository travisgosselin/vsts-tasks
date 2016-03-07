# Url Status Checker

### Overview
This task is used to check for status codes on a given URL and possible required content. Can be utilized to validate a website deployment, and possibly check a health check URL for content.

### The different parameters of the task are explained below
* **Url** The URL to perform the GET request against (including http), such as: http://www.google.ca
* **Required Content** Looking for possible content on the return (optional). If this content is not found in the page response, this check will fail. Leave blank to not use.
