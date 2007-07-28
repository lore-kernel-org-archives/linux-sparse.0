From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: looking for any examples of using sparse
Date: Sat, 28 Jul 2007 10:44:14 -0700
Message-ID: <20070728104414.ff81537a.rdunlap@xenotime.net>
References: <bb2368c50705090732w4948fcc0ka3aea74ba22945b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:53926 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755960AbXG1RjA (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 28 Jul 2007 13:39:00 -0400
Received: from midway.site ([71.245.96.223]) by xenotime.net for <linux-sparse@vger.kernel.org>; Sat, 28 Jul 2007 10:38:56 -0700
In-Reply-To: <bb2368c50705090732w4948fcc0ka3aea74ba22945b5@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mish Mash <khalota@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Wed, 9 May 2007 16:32:30 +0200 Mish Mash wrote:

> dear all,
> 
> I'm trying to use sparse for writing various source code analysis
> tools (I was using ctool previously). I'm currently going through the
> source trying to figure out what I need. Given the excessive amounts
> of comments I'm having to wade through, this probably isn't the
> fastest way of figuring the beast out ;)
> 
> Does anyone have any notes they've taken or can point me at code that
> uses sparse to help get a rough idea of how to use the beast? (Ideally
> slightly more detailed than Randy Dunlap's howto) I noticed smatch now
> uses sparse and i've applied their patch which I'm going over. Is
> there anything better? (I've already found the no longer very useful
> presentation at http://developer.osdl.org/dmo/sparse/)

[belated]

Hi,

My sparse howto was never meant to be a guide to sparse internals,
but agreed, something like that would be very helpful.

My sparse howto is really intended to be a basic/intro user guide since
I didn't find one anywhere else.  And I have just updated it --
comments/corrections welcome.

http://www.xenotime.net/linux/sparse/sparse_howto.txt

---
~Randy
