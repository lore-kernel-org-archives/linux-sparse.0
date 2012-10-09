From: Ed Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] linux/compiler.h: Add __must_hold macro for functions
 called with a lock held
Date: Tue, 9 Oct 2012 15:35:32 -0500
Message-ID: <C5833F40-2EA6-43DA-B69C-AFF59E76E0C9@coraid.com>
References: <20121008020610.GA9197@leaf>
 <20121009130637.5e61078f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from server505d.appriver.com ([98.129.35.42]:59054 "EHLO
	server505.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752609Ab2JIUfj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Oct 2012 16:35:39 -0400
In-Reply-To: <20121009130637.5e61078f.akpm@linux-foundation.org>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Triplett <josh@joshtriplett.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Andi Kleen <ak@linux.intel.com>

On Oct 9, 2012, at 4:06 PM, Andrew Morton wrote:

> On Sun, 7 Oct 2012 19:06:10 -0700
> Josh Triplett <josh@joshtriplett.org> wrote:
> 
>> linux/compiler.h has macros to denote functions that acquire or release
>> locks, but not to denote functions called with a lock held that return
>> with the lock still held.  Add a __must_hold macro to cover that case.
> 
> hum.  How does this work?  Any code examples and sample sparse output? 
> Does it apply to all lock types, etc?

I accidentally found a bug in sparse where sparse should have
been complaining about the locking in the aoe driver's
aoenet.c:tx function, which enters with the txlock spinlock held
and releases and reacquires it inside a loop.

When I modified the loop contents between lock release and
acquisition in a patch that I'm preparing now, sparse began
complaining about context imbalance.  (Before the modifications
to the tx function, sparse was exhibiting a bug by *not*
complaining.)  Here's the complaint:

  CHECK   drivers/block/aoe/aoenet.c
/build/ecashin/git/linux/arch/x86/include/asm/spinlock.h:81:9: warning: context imbalance in 'tx' - unexpected unlock
  CC [M]  drivers/block/aoe/aoenet.o

... although I used a smaller file to hone in on the issue when
discussing it on the linux-sparse mailing list:

  http://thread.gmane.org/gmane.comp.parsers.sparse/3091

Josh Triplett suggested I add an annotation telling sparse that
the function enters and exits with the lock held, but after
reading the sparse man page, where the context feature is
described, it looked like that meant specifying a 1 for both
parameters: __attribute__((context(x,1,1))), but there was no
macro for that.

The new patch from Josh Triplett adds the macro that I can use to
keep sparse informed about the locking requirements for the tx
function.

> IOW, where is all this stuff documented?

It wasn't real easy to find it, but it's basically something you
can infer from reading include/linux/compiler.h and the sparse.1
man page that's included with sparse.  I think a brief mention in
Documentation/sparse.txt of the relationship between the
sparse "context" feature and the locking annotations like
__acquires and __must_hold would be a nice addition.

I can take a stab at it if folks agree.

-- 
  Ed Cashin
  ecashin@coraid.com


