From: ricknu-0@student.ltu.se
Subject: Booleans, what a wonderful type!
Date: Wed, 18 Jul 2007 03:43:39 +0200
Message-ID: <1184723019.469d704b6111b@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gepetto.dc.ltu.se ([130.240.42.40]:50491 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbXGRCJv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Jul 2007 22:09:51 -0400
Received: from localhost (wc-special5.dc.ltu.se [130.240.42.175])
	by gepetto.dc.ltu.se (8.12.5/8.12.5) with ESMTP id l6I1hdmn005503
	for <linux-sparse@vger.kernel.org>; Wed, 18 Jul 2007 03:43:39 +0200 (MEST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Good morning to you all!

As most of you do not know, I am on Google's SoC
<http://code.google.com/soc/2007/sparse/appinfo.html?csaid=CB0974F67B64AD0C> to
add the ability to suggestions when booleans could/should be used.

Unforunatly, you need both a working internet connection and computer to work on
this, which I now appriciate how difficult it can be to manage, otherwise this
would have been sent _much_ earlier.


Anyhow, I would like any and all ideas on these:

* Should it make all the suggestions at the "same time" or should it first just
suggest the "source" of the boolean-change and then, when converted, suggest the
"users" of the source to change over?

* Should it really be handled by a -W-flag? After all, it is more of a
suggestion then a warning.


... and some questions:

* Most likly a _really_ stupid newbie question, but I have seen several of this
form:
<function>
{
        <variable> a;
        <doing something useful (no sign of 'a')>
        a = <some value/variable>;
        <exit>
}
How is this variable useful?

* Why is there no va_end() after va_start()?

According to the manual (STDARG(3)):
va_end
       Each invocation of va_start() must be matched by a corresponding  invo-
       cation  of va_end() in the same function. After the call va_end(ap) the
       variable ap is undefined.  Multiple  transversals  of  the  list,  each
       bracketed  by  va_start() and va_end() are possible.  va_end() may be a
       macro or a function.


* Is there any advantage of "for (;;)" instead of ex "while (true)"?

* Why is it written in C and not C++. Easier access to kernel-developers? (just
curious)


Have a good night.
Richard Knutsson
