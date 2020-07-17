# Scan using Fortify on Demand (FoD)

The FoD upload utility allows for uploading a zip file containing source code (and dependencies) to be scanned by 
Fortify on Demand. FoD users can manually package their source code in a zip file, taking into account the requirements 
listed in the FoD documentation, or they can utilize ScanCentral Client to package source code and dependencies automatically 
as illustrated by the following commands:

* `scancentral package -bt mvn -o package.zip`  
    Package source code and dependencies (if any) into a file named package.zip
* `java -jar FoDUpload.jar -portalurl <portalUrl> -apiurl <apiUrl> -tenantCode <tentant> -releaseId <releaseId> -z package.zip -uc <user> <password>`  
    Upload package.zip to FoD in order to be scanned

Note that this example utilizes ScanCentral Client **only** for packaging source code; we don't utilize any other
ScanCentral functionality, and this command does not require a ScanCentral environment to be installed. In order 
to use these commands, you will need to have both ScanCentral Client and the FoD Upload utility installed:

* ScanCentral Client can be downloaded from https://tools.fortify.com/scancentral/Fortify_ScanCentral_Client_20.1.0_x64.zip
* FoD upload utility is hosted at https://github.com/fod-dev/fod-uploader-java

