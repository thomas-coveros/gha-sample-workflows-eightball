# Fortify EightBall Sample

This project provides sample source code containing multiple vulnerabilities, including:

* Path Manipulation
* Unreleased Resource: Streams
* J2EE Bad Practices: Leftover Debug Code

The sections below describe how to:
* [Build and use the sample program](#sample-usage)
* [Scan the sample program using a local Fortify SCA installation](#local-scans)
* [Scan the sample program on a Fortify ScanCentral environment](#scan-using-fortify-scancentral)
* [Scan the sample program using Fortify on Demand (FoD)](#scan-using-fortify-on-demand-fod)

This document focuses on performing scans from the command line; please see the relevant documentation 
if you would want to utilize IDE or CI/CD plugins for scanning the source code.

# Sample usage

This sample Java program can be built using the `mvn clean package` Maven command, which will produce 
the `target/EightBall-1.0.jar` executable jar file. The sample program takes an integer as an argument:

* `java -jar target/EightBall-1.0.jar 0`
* `java -jar target/EightBall-1.0.jar 1`
* `java -jar target/EightBall-1.0.jar 2`
* `java -jar target/EightBall-1.0.jar 391`
* `java -jar target/EightBall-1.0.jar 2000`

Normally, this program replies with a message from the files 0, 1, or 2.  However,
due to bad error handling, if you put a filename instead of an integer as
the argument, it shows the contents of the file.  (For simplicity, the
user input comes from the command line argument.  What would happen if it
came from a web form?)  Try:

* `java jar target/EightBall-1.0.jar pom.xml`
* `java jar target/EightBall-1.0.jar /etc/passwd` (on Unix)
* `java jar target/EightBall-1.0.jar C:\autoexec.bat` (on Windows)

## Local Scans

The following sections describe how to run scans locally, for example on a developer workstation
or on a central build system that has Fortify Static Code Analyzer installed.

### Run Fortify SCA without build integration

The following commands illustrate the most basic way for performing a Fortify SCA scan, without
utilizing any build integration.

* `sourceanalyzer -b EightBall -clean`  
    Clean the EightBall build model
* `sourceanalyzer -b EightBall src/**/*`  
    Translate all source files with a known file extension located in the src directory tree. 
* `sourceanalyzer -b EightBall -scan -f EightBall.fpr`  
    Scan the previously translated source files and output potential vulnerabilities to EightBall.fpr

Note that this sample doesn't have any dependencies; for most projects you would also need to pass the 
`-cp <list of dependency jars>` option when translating the source code. Please see the Fortify Static 
Code Analyzer User Guide for details on available command line options.

The resulting EightBall.fpr file can be uploaded to Fortify Software Security Center (SSC), or opened using
Fortify Audit Workbench using the following command: `auditworkbench EightBall.fpr`

### Run Fortify SCA with Maven build integration

Build integrations provide various advantages, especially during the translation phase. For example,
the Maven build integration allows for automatically resolving dependencies, and allows for differentiating
between production and test code.

In order to use the Maven build integration, you will first need to intall the Fortify Maven Plugin; see the
Fortify Static Code Analyzer User Guide for details. Once the plugin has been installed, the following sections
describe various approaches for using the Maven build integration.

#### As a Maven plugin

* `mvn com.fortify.sca.plugins.maven:sca-maven-plugin:<version>:clean`  
    Clean the build model; the build id is automatically generated based on artifact id and version
* `mvn com.fortify.sca.plugins.maven:sca-maven-plugin:<version>:translate`  
    Translate the source code, using standard Maven mechanisms for locating source code and resolving dependencies
* `mvn com.fortify.sca.plugins.maven:sca-maven-plugin:<version>:scan`  
    Scan the previously translated source files and output potential vulnerabilities to an FPR file located in the `target/fortify` directory

#### Invoke Maven through Fortify SCA

* `sourceanalyzer -b EightBall -clean`  
    Clean the EightBall build model
* `sourceanalyzer -b EightBall mvn package`  
    Have sourceanalyzer invoke Maven for you to perform the translation 
* `sourceanalyzer -b EightBall -scan -f EightBall.fpr`  
    Scan the previously translated source files and output potential vulnerabilities to EightBall.fpr


## Scan using Fortify ScanCentral

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

## Scan using Fortify on Demand (FoD)

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

