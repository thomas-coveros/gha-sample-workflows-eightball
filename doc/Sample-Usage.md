# Sample usage

The source code for this sample program can be found in [src/main/java/com/fortify/sca/plugins/maven/samples/EightBall.java](../src/main/java/com/fortify/sca/plugins/maven/samples/EightBall.java). 
The source code can be built from the top-level directory using the `mvn clean package` Maven command, which will produce 
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
