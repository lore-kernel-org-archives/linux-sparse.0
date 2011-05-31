From: Christopher Li <sparse@chrisli.org>
Subject: Re: more "unreplaced symbol" warnings
Date: Tue, 31 May 2011 10:39:52 -0700
Message-ID: <BANLkTi=_0Xe8Fuq9aJ69Zqx3iQYq6E9N5w@mail.gmail.com>
References: <20110529145450.8c042971.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53445 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756944Ab1EaRjy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 31 May 2011 13:39:54 -0400
Received: by wya21 with SMTP id 21so3491833wya.19
        for <linux-sparse@vger.kernel.org>; Tue, 31 May 2011 10:39:53 -0700 (PDT)
In-Reply-To: <20110529145450.8c042971.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-sparse@vger.kernel.org

On Sun, May 29, 2011 at 2:54 PM, Randy Dunlap <rdunlap@xenotime.net> wrote:
> I see that there was a short thread in Feb. 2008 about unreplaced symbols.
> Here are more warnings from Linux 2.6.39-git18 mainline.
> Obviously lots of them are just repeats, but this is what I get from x86_64
> allmodconfig.
>
> Any suggestions about how to eliminate them?
> Thanks.
>
> include/linux/swab.h:51:16: warning: unreplaced symbol 'val'
> include/linux/swab.h:51:16: warning: unreplaced symbol 'val'

I am trying to produce those now. If you know  which C file causing
this warning would be great.

It just hit me that, if there is a script to help reproduce the error
would be great. I just give this error line it emits. The script takes the
C source file and try to eliminate as much lines as possible while
still reproduce the error.

Chris
