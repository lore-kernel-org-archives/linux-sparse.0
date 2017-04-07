From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 4/4] fix implicit zero initializer.
Date: Fri, 7 Apr 2017 02:13:48 +0200
Message-ID: <20170407001347.vehiimlrmrg6nayx@macbook.local>
References: <20170406230029.11384-1-luc.vanoostenryck@gmail.com>
 <20170406230029.11384-5-luc.vanoostenryck@gmail.com>
 <CA+55aFzH_69Yhqa+V+j64_Q4h2V9G_QsXj5HSuNL2bfwbrxckw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33708 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbdDGANw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Apr 2017 20:13:52 -0400
Received: by mail-wr0-f171.google.com with SMTP id g19so41170222wrb.0
        for <linux-sparse@vger.kernel.org>; Thu, 06 Apr 2017 17:13:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFzH_69Yhqa+V+j64_Q4h2V9G_QsXj5HSuNL2bfwbrxckw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Thu, Apr 06, 2017 at 04:39:53PM -0700, Linus Torvalds wrote:
> On Thu, Apr 6, 2017 at 4:00 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > The C standard requires that, when initializing an aggregate, all
> > fieds not explicitly initialized shall be implicity zero-initialized
> 
> Note the "all fields".
> 
> Which is not the same as "the whole aggregate" which is what you do.
> The parts that don't have fields at all are undefined.

Yes indeed. I didn't really think about this little subtility.

> I think your patch is fine, and you might as well clear the whole
> backing store, but I think strictly speaking you're initializing more
> than what the standard says.

Yes, absolutely.
For the moment it's quite crude but generate correct code
(unless we want to track the undefined values).
It should be smarter, though, because of these holes but also
because what I hinted in the note:
for the moment, 'struct { int a, b, c, } s = { 1, 2, 3, };'
will generate something like:
	store.96	$0 -> 0[s]
	store.32	$1 -> 0[s]
	store.32	$2 -> 4[s]
	store.32	$3 -> 8[s]
which is a bit sad.

-- Luc
