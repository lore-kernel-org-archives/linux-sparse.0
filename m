From: "Dan Carpenter" <error27@gmail.com>
Subject: Re: Moving smatch to use sparse
Date: Thu, 5 Oct 2006 01:41:03 -0700
Message-ID: <a63d67fe0610050141x251253fei59b93fff28505dc4@mail.gmail.com>
References: <a63d67fe0607140925h3665cd98ibc2fab07f6f80360@mail.gmail.com>
	 <a63d67fe0607151742l6a387783x59494b84de80be88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:504 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751238AbWJEIlF (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Oct 2006 04:41:05 -0400
Received: by ug-out-1314.google.com with SMTP id o38so161701ugd
        for <linux-sparse@vger.kernel.org>; Thu, 05 Oct 2006 01:41:03 -0700 (PDT)
In-Reply-To: <a63d67fe0607151742l6a387783x59494b84de80be88@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: smatch-discuss@lists.sf.net
Cc: linux-sparse@vger.kernel.org

Work on smatch is going ahead.  I have one real life check is working
and I've added a patched up the core code quite a bit.

 Makefile               |   15
 check_derefed_params.c |  171 +++++
 check_null_deref.c     |  178 +++++
 smatch.c               |   33 +
 smatch.h               |  138 ++++
 smatch_flow.c          |  462 ++++++++++++++
 smatch_helper.c        |  180 +++++
 smatch_hooks.c         |  125 ++++
 smatch_states.c        |  587 +++++++++++++++++++
 9 files changed, 1888 insertions(+), 1 deletion(-)

check_derefed_params prints out a message every time a function
dereferences a parameter without checking.  check_null_deref.c prints
out a message whenever code calls a funtion with possibly null
parameters.  Afterwards you sort the output for functions that are in
both lists like this:

   grep Und warns.out | cut -d ' ' -f 6,7 | sort | uniq > tmp
   grep unchecked warns.out | cut -d ' ' -f 7,8 | sort | uniq > tmp2
   cat tmp* | sort | uniq -c | sort -n | grep " 2 "

If you run the code with an allno config then you get 9 potential
errors but only one is real...

In drivers/char/tty_ioctl.c line 549, ld could possibly NULL if arg is
TCIFLUSH, TCIOFLUSH or TCOFLUSH which leads to a BUG_ON when
tty_ldisc_deref() is called.

It kind sucks to get so many false positives, but the old version of
smatch would have had more even more because it wasn't as good at
handling compound conditions.

The code is on:  http://smatch.sourceforge.net/sparse/

regards,
dan carpenter
