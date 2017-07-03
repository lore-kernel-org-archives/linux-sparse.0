From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Adding ignored attribute optimize
Date: Mon, 3 Jul 2017 22:41:23 +0200
Message-ID: <20170703204122.wpwp4hfottgog6os@ltop.local>
References: <CANeU7QnNNL1u3BxhWLebFqzn+9Y7hHKABDo_mkEqfwF+VO963Q@mail.gmail.com>
 <20170629070437.o6j2bkv6wdbcknwa@ltop.local>
 <CANeU7QnfvQ5KNFKvGGeJ1u7CDpd5wigosY0BrGNT1H0KouPHuA@mail.gmail.com>
 <20170701092440.egmgcexgwuuybzj7@ltop.local>
 <CANeU7Q=Zj6LT1--TP-XGouwVZVTgJor8h1+2GZ1r0HCjVa5pmw@mail.gmail.com>
 <20170702195818.2lhotikeq2ozjb2n@ltop.local>
 <CANeU7QndbPf7cGaCYixx=YqJzBxx4DmEiAwMNXNxvCirLRZK8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35946 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbdGCUl1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 3 Jul 2017 16:41:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id y5so22541454wmh.3
        for <linux-sparse@vger.kernel.org>; Mon, 03 Jul 2017 13:41:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QndbPf7cGaCYixx=YqJzBxx4DmEiAwMNXNxvCirLRZK8Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jul 03, 2017 at 11:23:48AM -0700, Christopher Li wrote:
> On Sun, Jul 2, 2017 at 12:58 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > "should report error" ...
> > What error exactly? Is there something that doesn't work on sparse
> > or on GCC's side regarding this 'require_context'? What need to be
> > fixed exactly?
> 
> Have you look at the require_context code causing the warning in the
> kernel? That code only issue require_context when compiling with sparse.

Yes, I have looked at the code. Not only looked at but also searching how
it is *used*. And the result is that the defined macros are aither:
* not used (__protexted_{read,write}_by()
* always used with a macro that *also* use __context__ (__must_hold())
* a single exception: a member is declared with __protect_by() but that
  change exactly nothing.
In other words, this __require_context() has exactly zero effect and
doesn't need any fixes. It can simply be removed.

> The fix should be just either convert to context parsing sparse supported,
> implement in sparse, or just remove the require_context in kernel. It is
> not doing any thing there right now. What else do you thing it is the
> right fix for it?

There is nothing to fix since nothing is broken and everything works
as it should, including sparse's context checking. At worse, someone
use for this code a version of sparse that support other kind of context
checking that was never officially supported.

> > That's *exactly* why sparse should *not* report. You have no way to
> > tell if what you're reporting is legitimate or not. And in most
> > cases it's legitimate on GCC's side but you still want to report it.
> 
> I don't like sparse warn on the legit gcc attribute either.
> I have some patch should make both of us happy.
> 
> GCC is open. It is not that hard to get a full list of gcc supported
> attribute names.  I add the full list of gcc supported attribute list
> into the sparse. Sparse should not warn on any known gcc attributes
> any more. Patch on the way.
> 
> Let's be done with this.

Will your patch also cover the new attributes in GCC8? And the ones
that clang use now or will use in the short future? Or those used
by some othesr compilers that use the same syntax, like does the
ARM's compiler?

-- Luc
