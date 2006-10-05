From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: Moving smatch to use sparse
Date: Thu, 05 Oct 2006 17:52:25 +0200
Message-ID: <45252A39.3050008@redhat.com>
References: <a63d67fe0607140925h3665cd98ibc2fab07f6f80360@mail.gmail.com>	 <a63d67fe0607151742l6a387783x59494b84de80be88@mail.gmail.com> <a63d67fe0610050141x251253fei59b93fff28505dc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58280 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751617AbWJEPwh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Oct 2006 11:52:37 -0400
In-Reply-To: <a63d67fe0610050141x251253fei59b93fff28505dc4@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: smatch-discuss@lists.sourceforge.net, linux-sparse@vger.kernel.org

Hello Dan,

Dan Carpenter wrote:
> Work on smatch is going ahead.  I have one real life check is working
> and I've added a patched up the core code quite a bit.
great work! What about the old smatch.pm and perl scripts? Will i be
still able to use those or would i have to port them over? I'm still
using the old smatch on checking Wine.

bye
	michael

> 
> Makefile               |   15
> check_derefed_params.c |  171 +++++
> check_null_deref.c     |  178 +++++
> smatch.c               |   33 +
> smatch.h               |  138 ++++
> smatch_flow.c          |  462 ++++++++++++++
> smatch_helper.c        |  180 +++++
> smatch_hooks.c         |  125 ++++
> smatch_states.c        |  587 +++++++++++++++++++
> 9 files changed, 1888 insertions(+), 1 deletion(-)
> 
> check_derefed_params prints out a message every time a function
> dereferences a parameter without checking.  check_null_deref.c prints
> out a message whenever code calls a funtion with possibly null
> parameters.  Afterwards you sort the output for functions that are in
> both lists like this:
> 
>   grep Und warns.out | cut -d ' ' -f 6,7 | sort | uniq > tmp
>   grep unchecked warns.out | cut -d ' ' -f 7,8 | sort | uniq > tmp2
>   cat tmp* | sort | uniq -c | sort -n | grep " 2 "
> 
> If you run the code with an allno config then you get 9 potential
> errors but only one is real...
> 
> In drivers/char/tty_ioctl.c line 549, ld could possibly NULL if arg is
> TCIFLUSH, TCIOFLUSH or TCOFLUSH which leads to a BUG_ON when
> tty_ldisc_deref() is called.
> 
> It kind sucks to get so many false positives, but the old version of
> smatch would have had more even more because it wasn't as good at
> handling compound conditions.
> 
> The code is on:  http://smatch.sourceforge.net/sparse/


-- 
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart
