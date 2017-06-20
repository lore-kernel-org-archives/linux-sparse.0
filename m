From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] dissect: use built_in_ident() instead of MK_IDENT()
Date: Tue, 20 Jun 2017 18:07:11 +0200
Message-ID: <20170620160711.GA23849@redhat.com>
References: <20170619211454.45244-1-luc.vanoostenryck@gmail.com>
 <20170620111740.GB21354@redhat.com>
 <20170620125345.nlchvizgz5ar5yrn@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbdFTQHN (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 12:07:13 -0400
Content-Disposition: inline
In-Reply-To: <20170620125345.nlchvizgz5ar5yrn@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Chris Li <sparse@chrisli.org>

On 06/20, Luc Van Oostenryck wrote:
>
> On Tue, Jun 20, 2017 at 01:17:41PM +0200, Oleg Nesterov wrote:
> > On 06/19, Luc Van Oostenryck wrote:
> > >
> > > The motivation for this patch was to allow sparse to be
> > > compiled with clang which doesn't like what is done
> > > on VLAs in the MK_IDENT() macro.
> >
> > could you spell please? I don't understand why clang can't compile this
> > code and I am just curious.
>
> Sure, I should have added in the commit message. Here it is:
> 	test-dissect.c:50:16: warning: field 'ident' with variable sized type 'struct ident' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
> 	                sym->ident = MK_IDENT("__asm__");
> 	                             ^
> 	./dissect.h:31:16: note: expanded from macro 'MK_IDENT'
> 	                struct ident ident;                     \
> 	                             ^
> 	test-dissect.c:50:25: error: initialization of flexible array member is not allowed
> 	                sym->ident = MK_IDENT("__asm__");
> 	                                      ^~~~~~~~~
> 	./dissect.h:35:11: note: expanded from macro 'MK_IDENT'
> 	                .name = s,                              \
> 	                        ^

Hmm. Now that I git-cloned the code I understand. And I can't recall why MK_IDENT() was
written this way, it simply doesn't look right. Probably can be fixed but I agree, lets
remove it.

> > > But also, I can't see any justification for not using the
> > > real thing to create identifiers: built_in_ident().
> >
> > Simply because MK_IDENT() is faster and simpler to use.
>
> I find this very weak. For the simplicity of use, in both cases
> there is just a single call with the same argument, for the speed,
> I really really doubt there is any measurable difference.

Yes, I didn't try to convince you this optimization actually makes sense,
just explained the motivation I (probably) had many years ago.

> > >  dissect.h      | 13 -------------
> > >  test-dissect.c |  6 +++---
> > 
> > iirc there should be another MK_IDENT user in dissect.c?
> 
> No, it doesn't seem to, and the history tell that there it
> never had been the case, just the three in test-dissect.c

OK, my memory fooled me.

Thanks,

Oleg.

