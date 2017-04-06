# SFDX  App
This application is an exercise in how to build and deploy lightning components using SalesforceDX.
A simple app that is used for capturing daily readings of Blood Pressure and Weight. 

This has two custom objects and a Lightning Component that handles the inserts

## Dev, Build and Test
```
git checkout
cd health-app
sfdx force:org:create -s -f config/workspace-scratch-def.json
sfdx force:source:push
sfdx force:apex:test 
sfdx force:org:open
```




