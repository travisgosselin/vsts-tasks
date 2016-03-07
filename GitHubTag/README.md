# Git Tag

### Overview
This scripts performs a lightweight tag addition to a certain repository via the git hub api.

### The different parameters of the task are explained below
* **Tag** The tag to add to the repository found in the working directory. Assumed credentials are cached and tag is auto pushed after adding.
* **Repository Name** The name of the repository to add thte tag to.
* **Commit** The SHA commit id to which the tag should be applied. By default is $(Build.SourceVersion), which is the building commit id.
* **Owner** The owner of the repository to form the URL.
* **AuthToken** The OAuth token for a user with write permission to this repository to create the tag.