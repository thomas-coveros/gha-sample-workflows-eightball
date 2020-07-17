# Scan using Fortify ScanCentral

Fortify ScanCentral allows for offloading translation and scan to a centrally managed pool of scan machines.
The example command listed below packages the EightBall source code using Maven integration, and offloads
translation and scan to the ScanCentral environment. Obviously, you will need to have a running ScanCentral
environment in order to use this command. The scancentral.bat command is included with existing Fortify SCA
installations, or can be installed separately using the bundle provided with the ScanCentral installation media.

* `scancentral.bat -url <controller_url> start -bt mvn`

Variations of this command allow scan results to be automatically uploaded to Fortify Software Security Center (SSC)
once the scan has been completed on the ScanCentral environment. The ScanCentral command can also be used to query
current scan status, and download the scan results as an FPR file. Please the the Fortify ScanCentral Usage Guide
for more details.