# aws-codedeploy-windows-scripts

## Overview
These are basic appspec.yml and before/after install scripts (powershell) that will work for code deploy to Windows.

Place these in your web project.  Set the build action for each to "Content".  Copy to Output Directory should be "Copy always".

## Instructions
Place these files in the root of your application.  AWS CodeDeploy looks for the appspec.yml file to start the deployment process.

## appspec.yml Description

This appspec file tells CodeDeploy to copy the entire archive to the C:\inetpub\wwwroot folder in Windows.
```
version: 0.0
os: windows
files:
  - source: \
    destination: C:\inetpub\wwwroot
```

The hooks section supplies commands to be executed with the corresponding deploy events BeforeInstall and AfterInstall.  The commands are given a timeout of 900 seconds.  

```
hooks:
  BeforeInstall:
  - location: \before-install.ps1
    timeout: 900
  AfterInstall:
  - location: \after-install.ps1
    timeout: 900
```

## before-install.ps1
This file gets executed just before the content of the archive is copied to the server.  It shuts down the AppPool in IIS and also stops IIS.  If the web site has not been shut down, you may receive errors when CodeDeploy is trying to remove and copy files.  It also attempts to install IIS if it has not been installed.

## after-install.ps1
This file gets executed after all the code has been copied to the destination.  It simply starts the AppPool and starts IIS.
