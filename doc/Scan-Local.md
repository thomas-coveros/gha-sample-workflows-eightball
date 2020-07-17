# Local Scans

The following sections describe how to run scans locally, for example on a developer workstation
or on a central build system that has Fortify Static Code Analyzer installed.

## Run Fortify SCA without build integration

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

## Run Fortify SCA with Maven build integration

Build integrations provide various advantages, especially during the translation phase. For example,
the Maven build integration allows for automatically resolving dependencies, and allows for differentiating
between production and test code.

In order to use the Maven build integration, you will first need to intall the Fortify Maven Plugin; see the
Fortify Static Code Analyzer User Guide for details. Once the plugin has been installed, the following sections
describe various approaches for using the Maven build integration.

### As a Maven plugin

* `mvn com.fortify.sca.plugins.maven:sca-maven-plugin:<version>:clean`  
    Clean the build model; the build id is automatically generated based on artifact id and version
* `mvn com.fortify.sca.plugins.maven:sca-maven-plugin:<version>:translate`  
    Translate the source code, using standard Maven mechanisms for locating source code and resolving dependencies
* `mvn com.fortify.sca.plugins.maven:sca-maven-plugin:<version>:scan`  
    Scan the previously translated source files and output potential vulnerabilities to an FPR file located in the `target/fortify` directory

### Invoke Maven through Fortify SCA

* `sourceanalyzer -b EightBall -clean`  
    Clean the EightBall build model
* `sourceanalyzer -b EightBall mvn package`  
    Have sourceanalyzer invoke Maven for you to perform the translation 
* `sourceanalyzer -b EightBall -scan -f EightBall.fpr`  
    Scan the previously translated source files and output potential vulnerabilities to EightBall.fpr
