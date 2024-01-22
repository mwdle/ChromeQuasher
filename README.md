# ChromeQuasher
A Windows tool to terminate malfunctioning, CPU hogging, headless instances of Google Chrome and Chrome Driver spawned by a bug in Selenide versions below 6.17.0.    <br><br>    

## Read this first:
As of Selenide version 6.17.0 the issue that led to the creation of ChromeQuasher has been fixed with Selenide's automatic management of WebDrivers. Therefore, this tool does not serve much purpose in practical applications and stands here only as a reference. In turn, this application will not receive any updates and is not guaranteed to function properly with Chrome, ChromeDriver, or Selenide as more updates to those programs are released.

# Context:
I currently work as a QA Software Developer and one of my main roles in this position is to produce automated functional tests (AFT's) for my employer's websites. I use the Selenide for Java library in conjunction with Google Chrome and ChromeDriver in order to accomplish this. The issue this programs aims to help fix stemmed from a problem with Selenide's integration with ChromeDriver, which frequently resulted in significant numbers of Chrome and ChromeDriver instances being opened invisibly on my work machine, in turn causing high CPU consumption.    <br><br>    

### Other instances of people facing this issue:
* https://github.com/SeleniumHQ/selenium/issues/5600
* https://bugs.chromium.org/p/chromedriver/issues/detail?id=2311
* https://github.com/selenide/selenide/issues/1398
* https://stackoverflow.com/questions/41711019/selenium-too-many-chrome-processes-raise-when-i-initiate-instances-of-web-drive
* https://github.com/nightwatchjs/nightwatch/issues/879

# Functionality:
The main function of this program is to find and terminate broken instances of Chrome and ChromeDriver spawned by the Selenide bug, without killing any actual valid instances being used by you or a Selenide app. Therefore, this program is safe to execute while using Chrome, as it will only kill bugged and broken instances spawned by Selenide and will _not_ interfere with any normal/active instances of Chrome.    <br><br>    

This script is most useful when triggered by task scheduler at frequent intervals.
