# ChromeQuasher
A Windows tool to terminate malfunctioning, CPU hogging, headless instances of Google Chrome and Chrome Driver spawned by a bug in Selenide versions below 6.17.0.    <br><br>    

## Read this first:
As of Selenide version 6.17.0 (as far as I know) this issue has been fixed with Selenide's automatic management of WebDrivers. Therefore, this program does not serve much purpose in practical applications and stands here as a reference.

# Context:
I currently work as a QA Software Developer and one of my main roles in this position is to produce automated functional tests for my employer's websites. I use the Selenide for Java library in conjunction with Google Chrome and ChromeDriver in order to accomplish this. The issue this programs aims to help fix stemmed from a problem with Selenide's integration with ChromeDriver, which frequently resulted in significant numbers of Chrome and ChromeDriver instances being opened invisibly on my work machine, in turn causing high CPU consumption.    <br><br>    

# Functionality:
The main function of this program is to find and terminate broken instances of Chrome and ChromeDriver spawned by the Selenide bug, without killing any actual valid instances being used by you or a Selenide app. Therefore, this program is safe to execute while using chrome, as it will _not_ interfere with any regular instances of Chrome.  It will only kill bugged and broken instances spawned by Selenide.    <br><br>    

This script is most useful when triggered by task scheduler at frequent intervals.
