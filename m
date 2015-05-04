From: Alexander Riesen <alexander.riesen@cetitec.com>
Subject: Why sparse does not support context tracking?
Date: Mon, 04 May 2015 13:05:22 +0200
Message-ID: <55475272.90705@cetitec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:55472 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbEDLFb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 May 2015 07:05:31 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>, Christopher Li <sparse@chrisli.org>, Johannes Berg <johannes@sipsolutions.net>

Hi,

I tried to instrument my code (a kernel driver) with __must_hold hints
and noticed that they don't really work: a definitely broken code caused
no errors from sparse.

A test in the "sparse" tree confirmed. Here is the test I used:

static int ctx;

static void must_hold(void) __attribute__((context(ctx,1,1)))
{
     if (ctx)
         ;
}
static void bad_must_hold(void)
{
     must_hold();
}

After a bit of looking I found a commit which removed context tracking
from the "sparse":

Author: Johannes Berg <johannes@sipsolutions.net> 2008-12-23 10:59:22

     Revert the context tracking code

     > Do you want to resend your change which revert the context changes?
     > Make it base on Josh's git's tree and I will merge your changes in my
     > branch.

     Below. Or I can give it to you in git if you prefer. I still think we
     should redo this in some form so that annotations with different
     contexts can work properly, but I don't have time to take care of it
     right now.

     johannes

     >From ca95b62edf1600a2b55ed9ca0515d049807a84fc Mon Sep 17 00:00:00 2001
     From: Johannes Berg <johannes@sipsolutions.net>
     Date: Tue, 23 Dec 2008 10:53:19 +0100
     Subject: [PATCH] Revert context tracking code

So it seems that the code has problems with different contexts. Still, it seems
a bit heavy-handed to remove it completely (assuming it worked, of course).
The kernel even has a bit of use for it (not much, admittedly: DRBD and aoe).

Is it be possible to reintroduce the code at least for the same context?
So that it catches at least some locks not taken?

Regards,
Alex Riesen


