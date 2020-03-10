From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Add symantic index utility
Date: Tue, 10 Mar 2020 18:12:02 +0100
Message-ID: <20200310171202.y5rhsydmmbewoarm@ltop.local>
References: <20200309152509.6707-1-gladkov.alexey@gmail.com>
 <20200309223701.dbnej7esb4qp56bm@ltop.local>
 <20200310150713.GB19012@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36316 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCJRMG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 10 Mar 2020 13:12:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id s5so12980611wrg.3
        for <linux-sparse@vger.kernel.org>; Tue, 10 Mar 2020 10:12:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200310150713.GB19012@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Tue, Mar 10, 2020 at 04:07:14PM +0100, Oleg Nesterov wrote:
> 
> Annoyingly, this triggers a lot of sparse_error's in pre-process.c:collect_arg().
> And just in case, of course this is not specific to dissect/sindex, ./sparse or
> anything else will equally complain.
> 
> For example,
> 
>   1011  static inline bool page_expected_state(struct page *page,
>   1012                                          unsigned long check_flags)
>   1013  {
>   1014          if (unlikely(atomic_read(&page->_mapcount) != -1))
>   1015                  return false;
>   1016
>   1017          if (unlikely((unsigned long)page->mapping |
>   1018                          page_ref_count(page) |
>   1019  #ifdef CONFIG_MEMCG
>   1020                          (unsigned long)page->mem_cgroup |
>   1021  #endif
>   1022                          (page->flags & check_flags)))
>   1023                  return false;
>   1024
>   1025          return true;
>   1026  }
> 
> leads to
> 
> 	mm/page_alloc.c:1019:1: error: directive in macro's argument list
> 	mm/page_alloc.c:1021:1: error: directive in macro's argument list
> 
> and it is not immediately clear why. Yes, because "unlikely" is a macro.
> 
> Can't we simply remove this sparse_error() ? "#if" inside the macro's args
> is widely used in kernel, gcc doesn't complain, afaics pre-process.c handles
> this case correctly.

I'm quite reluctant to simply suppress it.
My (contradictory) point of view is that it is because it's not
immediately clear there is a problem that the warning is needed
but, OTOH, people and the Standard, want to use macros transparently
so a macro wrapping a function call should behave just like directly
calling the function. And yes both Sparse and GCC seem to be able
to handle this, so it's maybe only a restriction for more primtive
preprocessors. I dunno.

Some arguments/justifications for the arning can be found at:
	https://www.spinics.net/lists/kernel/msg1636994.html

Anyway, only a warning should be issued (I'll send a patch for this).
I also wouldn't mind to add a new warning flag to suppress it,
something like -Wno-directive-within-macro.

-- Luc
