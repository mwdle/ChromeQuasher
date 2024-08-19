# ChromeQuasher  

A Windows utility to terminate malfunctioning, CPU hogging, headless instances of Google Chrome and Chrome Driver spawned by a bug in Selenide versions below 6.17.0. This program is a _band-aid_ fix for a buggy testing framework.  

## Table of Contents  

* [Description](#chromequasher)  
* [Read This First](#read-this-first)  
* [Context](#context)
* [Tips](#tips)
* [Other instances of people facing this issue](#other-instances-of-people-facing-this-issue)
* [License](#license)  
* [Disclaimer](#disclaimer)  

## Read this first  

As of Selenide version 6.17.0 the issue that led to the creation of ChromeQuasher has been fixed with Selenide's overhaul of WebDriver management. Therefore, this tool does not serve any purpose in practical applications and stands here only as a reference. Consequentially, this application will not be updated and is not guaranteed to function properly indefinitely, as new versions of Chrome, ChromeDriver, and Selenide are released. As of the time of writing (1/21/24), the script is still both functional and compatible with the latest versions of the aforementioned programs.  

## Context  

I currently work as an intern in QA Automated Test Engineering and one of my main roles in this position is to produce automated functional tests (AFT's) for my employer's websites. I use Selenide for Java in conjunction with Google Chrome and ChromeDriver in order to accomplish this. The issue this programs aims to help 'fix' stemmed from a problem with Selenide's integration with ChromeDriver, which frequently resulted in significant numbers of Chrome and ChromeDriver instances being opened invisibly on my work machine, in turn causing high CPU consumption.  

## Functionality  

The main function of this program is to find and terminate broken instances of Chrome and ChromeDriver spawned by the Selenide bug, without killing any actual valid instances being used by you or a Selenide app. Therefore, this program is safe to execute while using Chrome, as it will only kill bugged and broken instances spawned by Selenide and will _not_ interfere with any normal/active instances of Chrome.  

### Tips

This script is most useful when triggered by task scheduler at frequent intervals.  

## Other instances of people facing this issue

* [github.com/SeleniumHQ](https://github.com/SeleniumHQ/selenium/issues/5600)
* [chromium.org](https://bugs.chromium.org/p/chromedriver/issues/detail?id=2311O)
* [github.com/selenide](https://github.com/selenide/selenide/issues/1398)
* [stackoverflow.com](https://stackoverflow.com/questions/41711019/selenium-too-many-chrome-processes-raise-when-i-initiate-instances-of-web-drive)
* [github.com/nightwatchjs](https://github.com/nightwatchjs/nightwatch/issues/879)

## License  

This project is licensed under the GNU General Public License v3.0 (GPL-3.0). See the [LICENSE](LICENSE.txt) file for details.  

## Disclaimer  

This repository is provided as-is and is intended for informational and reference purposes only. The author assumes no responsibility for any errors or omissions in the content or for any consequences that may arise from the use of the information provided. Always exercise caution and seek professional advice if necessary.  
