From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] dissect: use built_in_ident() instead of MK_IDENT()
Date: Tue, 20 Jun 2017 14:53:46 +0200
Message-ID: <20170620125345.nlchvizgz5ar5yrn@ltop.local>
References: <20170619211454.45244-1-luc.vanoostenryck@gmail.com>
 <20170620111740.GB21354@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37368 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdFTMxt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 08:53:49 -0400
Received: by mail-wm0-f47.google.com with SMTP id d73so19305579wma.0
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 05:53:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170620111740.GB21354@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-sparse@vger.kernel.org, Chris Li <sparse@chrisli.org>

On Tue, Jun 20, 2017 at 01:17:41PM +0200, Oleg Nesterov wrote:
> On 06/19, Luc Van Oostenryck wrote:
> >
> > The motivation for this patch was to allow sparse to be
> > compiled with clang which doesn't like what is done
> > on VLAs in the MK_IDENT() macro.
> 
> could you spell please? I don't understand why clang can't compile this
> code and I am just curious.

Sure, I should have added in the commit message. Here it is:
	test-dissect.c:50:16: warning: field 'ident' with variable sized type 'struct ident' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
	                sym->ident = MK_IDENT("__asm__");
	                             ^
	./dissect.h:31:16: note: expanded from macro 'MK_IDENT'
	                struct ident ident;                     \
	                             ^
	test-dissect.c:50:25: error: initialization of flexible array member is not allowed
	                sym->ident = MK_IDENT("__asm__");
	                                      ^~~~~~~~~
	./dissect.h:35:11: note: expanded from macro 'MK_IDENT'
	                .name = s,                              \
	                        ^
	./token.h:77:7: note: initialized flexible array member 'name' is here
	        char name[];            /* Actual identifier */
	             ^
	test-dissect.c:50:14: error: assigning to 'struct ident *' from incompatible type 'void'
	                sym->ident = MK_IDENT("__asm__");
	                           ^ ~~~~~~~~~~~~~~~~~~~

I quickly looked at it and I didn't seem to be something with MK_IDENT,
just that clang doesn't like initialization of flexible array member
(I said 'VLA' in the patch but there is no VLA here).
 
> > But also, I can't see any justification for not using the
> > real thing to create identifiers: built_in_ident().
> 
> Simply because MK_IDENT() is faster and simpler to use.

I find this very weak. For the simplicity of use, in both cases
there is just a single call with the same argument, for the speed,
I really really doubt there is any measurable difference.
But what annoys me is that the macro is doing another kind
of ident (other init code, not being hashed, different lifetime),
not that it matters here though but ...

> > CC: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  dissect.h      | 13 -------------
> >  test-dissect.c |  6 +++---
> 
> iirc there should be another MK_IDENT user in dissect.c?

No, it doesn't seem to, and the history tell that there it
never had been the case, just the three in test-dissect.c

-- Luc
