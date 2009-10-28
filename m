From: Holger Freyther <zecke@selfish.org>
Subject: User question for =?utf-8?b?X19jb250ZXh0X18=?= or similiar
Date: Wed, 28 Oct 2009 10:56:36 +0000 (UTC)
Message-ID: <loom.20091028T113843-308@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36545 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbZJ1LAD (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 28 Oct 2009 07:00:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N36G4-0000dO-UE
	for linux-sparse@vger.kernel.org; Wed, 28 Oct 2009 12:00:05 +0100
Received: from 123-192-145-111.dynamic.kbronet.com.tw ([123.192.145.111])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Wed, 28 Oct 2009 12:00:04 +0100
Received: from zecke by 123-192-145-111.dynamic.kbronet.com.tw with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Wed, 28 Oct 2009 12:00:04 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I would like to use sparse on the OpenBSC[1] userspace application
and I'm searching for a hint on how to realize it or how to adopt the
sparse code to do the following.

In the code we have a struct called "struct gsm_subscriber" and it
is reference counted. We have various methods that query the 
database (VLR) to find a subscriber and then we have subscr_put
and subscr_get to operate on the reference count.

One rule we have established in the code is that the "reference" is
never borrowed. This means code that is doing a subscr_get or a query
will need to do subscr_put on all exits paths. The only exception is
e.g. if work needs to be scheduled and the pointer is put into a talloc
allocated structure.

My first thought was that this almost works like locking in the kernel
but I was wrong. I have used the CHECKER macros from linux/compiler.h

and changed code to

struct gsm_subscriber *subscr_get(struct gsm_subscriber *subscr)
                                          __acquires(subscr);
struct gsm_subscriber *subscr_put(struct gsm_subscriber *subscr)
                                         __releases(subscr);
struct gsm_subscriber *subscr_find_by_tmsi(int tmsi)
                                         __acquires(subscr);

and the code like

do_something()
{
    subscr = subscr_find_by_tmsi(tmsi);
    if (!subscr)
           return;

   if (some_condition) {
...
          subscr_put(subscr);
   }

...
   return;
}

My assumption would be that sparse is looking at the flows and figures
out that one path exits without subscr_put being called. Is my assumption
wrong, would it be worth adding a check that goes through the flow and
counts ref's/unref's? Am I doing it completely wrong?

help and pointers to the code are very much appreciated.

      z.

PS: I will update the wiki with some explanation when I get it to work.


[1] http://openbsc.gnumonks.org

