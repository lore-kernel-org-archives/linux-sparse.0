From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] sparse: make __builtin_object_size argument const
Date: Tue, 04 Oct 2016 10:55:47 +0200
Message-ID: <1475571347.5324.38.camel@sipsolutions.net>
References: <1475571285-18180-1-git-send-email-johannes@sipsolutions.net>
         (sfid-20161004_105450_500285_EEC7CC6D)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:40634 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbcJDIzv (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Oct 2016 04:55:51 -0400
In-Reply-To: <1475571285-18180-1-git-send-email-johannes@sipsolutions.net> (sfid-20161004_105450_500285_EEC7CC6D)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, Lance Richardson <lrichard@redhat.com>

On Tue, 2016-10-04 at 10:54 +0200, Johannes Berg wrote:
> gcc clearly allows that, and this makes no difference since we
> can still pass a non-const pointer without warnings.
> 
> Add a test for it, while at it.

Oh, now I see Lance already sent this patch, sorry. I have a test, if
you like that better, but whatever. Would be nice if you could apply
either one though :)

Thanks,
johannes
