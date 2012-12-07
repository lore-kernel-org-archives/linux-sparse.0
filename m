From: Tom Schmid <scth2000@yahoo.de>
Subject: Many warnings when building sparse with MinGW- format specifiers for "printf"
Date: Fri, 7 Dec 2012 12:07:14 +0000 (GMT)
Message-ID: <1354882034.95572.YahooMailNeo@web29702.mail.ird.yahoo.com>
Reply-To: Tom Schmid <scth2000@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm21-vm6.bullet.mail.ird.yahoo.com ([212.82.109.246]:36503 "EHLO
	nm21-vm6.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752775Ab2LGMHQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 7 Dec 2012 07:07:16 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

Hello, 


it was the first time, that i tried to build sparse on MinGW - I used cygwin in the past. 
Now building sparse on MinGW (GCC 4.6.2) comes up with several of these warnings: 

parse.c:1695:3: warning: unknown conversion type character 'l' in format [-Wformat] 
parse.c:1695:3: warning: too many arguments for format [-Wformat-extra-args] 

See also sourceforge.net/apps/trac/mingw-w64/wiki/gnu printf 

It seems, that MinGW doesn't accept the "old style" format specifiers like "%llu". 
That means, that functions like printf will not work as expected, if these "old style" format specifiers are used. 

Is this a known problem? 
Is there any hint or workaround? 


Regards, 
Thomas Schmid

