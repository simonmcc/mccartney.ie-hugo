---
title: Using embedded Shared Libraries & Global Variables
author: simonm
type: post
date: 2022-08-18
url: /jenkins-shared-libraries-and-the-PR-workflow/
categories:
  - Jenkins

---

Testing CI code is hard, even when you're using a "proper" language like Jenkin's Groovy based pipeline DSL.

Here's a technique for using Shared Library components in pipeline & multbranchPipeline projects, and tracking any embedded libraries:
```
├── Jenkinsfile
├── vars
│   ├── log.groovy
```

```groovy
# Jenkinsfile
pipeline {
  agent any

  stages {
    stage('setup') {
      steps {
        script {
          // dynamically load pipeline library from the current branch of this repo.
          // multibranchPipeline will set env.CHANGE_BRANCH or env.BRANCH_NAME
          // use the CHANGE_BRANCH if it's set (indicating that we're on a PR job,
          // where GIT_BRANCH is the PR, not a real git branch)
          def branch = (env.CHANGE_BRANCH != null) ? env.CHANGE_BRANCH : env.BRANCH_NAME
          // if this is a regular pipeline, branch is in env.GIT_BRANCH
          branch = (branch != null) ? branch : env.GIT_BRANCH
          library identifier: "axon-library-k8s-deploy@${branch}",
            retriever: modernSCM([$class: 'GitSCMSource',
                          credentialsId: scm.getUserRemoteConfigs()[0].getCredentialsId(),
                          remote: scm.getUserRemoteConfigs()[0].getUrl()])

          // check that the library loaded
          log.info 'This is a dynamically loaded step'
        }
      }
    }
    stage('build') {
      steps {
        echo "do actual stuff here"
      }
    }
  }
}
```

```groovy
// vars/log.groovy
def info(message) {
    echo "INFO: ${message}"
}
```