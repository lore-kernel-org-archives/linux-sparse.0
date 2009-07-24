From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/5] Fix some "enum value 'SYM_...' not handled in switch"
 	warnings
Date: Fri, 24 Jul 2009 19:25:02 +0100
Message-ID: <4A69FC7E.7020600@ramsay1.demon.co.uk>
References: <4A62338A.1060600@ramsay1.demon.co.uk>	 <20090719140125.GA25417@feather>	 <4A663005.5090009@ramsay1.demon.co.uk> <70318cbf0907211729j51e48ca0p430d898a5cb86bc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:61364 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753732AbZGXTeQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 24 Jul 2009 15:34:16 -0400
In-Reply-To: <70318cbf0907211729j51e48ca0p430d898a5cb86bc8@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> OK. I don't want to list all the enumerate value here just for the
> sake of gcc warnings.
> It makes the code ugly. Nor do I want to change the gcc flags used to compile
> sparse. If the newest gcc still complain on those. I would rather add
> the blank default
> to make it clean. Since latest gcc doesn't issue warning on those. I
> think it is fine to
> leave it as it is.
> 

OK, no problem. I can maintain this in my cygwin repo, along with the
__sentinel__ attribute patch. (As before, I don't need this on Linux).

Just FYI, I had planned to fix this by implementing a local makefile
config file (like config.mak in git), so that I could fix this issue
locally ("out of tree").

However, I was (pleasantly) surprised to find that I'd been beaten to
the punch by Samuel Bronson in commit 8d86d0e.

So I tried this local.mk file:

    OS=cygwin
    CFLAGS+=-Wno-switch-enum

This lead to the invocation of gcc I was hoping for; something like:

    gcc ... -Wall ... -Wno-switch-enum parse.c

which I had expected to suppress the warnings. It didn't. *Ho-Hum* ;-)

ATB,
Ramsay Jones


