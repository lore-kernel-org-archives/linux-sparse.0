From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] Add symantic index utility
Date: Wed, 11 Mar 2020 12:33:52 +0100
Message-ID: <20200311113351.GA19327@redhat.com>
References: <20200309152509.6707-1-gladkov.alexey@gmail.com>
 <20200309223701.dbnej7esb4qp56bm@ltop.local>
 <20200310150713.GB19012@redhat.com>
 <20200311090745.GD11561@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50338 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726000AbgCKLeA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 11 Mar 2020 07:34:00 -0400
In-Reply-To: <20200311090745.GD11561@kadam>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On 03/11, Dan Carpenter wrote:
>
> On Tue, Mar 10, 2020 at 04:07:14PM +0100, Oleg Nesterov wrote:
> > Annoyingly, this triggers a lot of sparse_error's in pre-process.c:collect_arg().
> > And just in case, of course this is not specific to dissect/sindex, ./sparse or
> > anything else will equally complain.
> >
> > For example,
> >
> >   1011  static inline bool page_expected_state(struct page *page,
> >   1012                                          unsigned long check_flags)
> >   1013  {
> >   1014          if (unlikely(atomic_read(&page->_mapcount) != -1))
> >   1015                  return false;
> >   1016
> >   1017          if (unlikely((unsigned long)page->mapping |
> >   1018                          page_ref_count(page) |
> >   1019  #ifdef CONFIG_MEMCG
> >   1020                          (unsigned long)page->mem_cgroup |
> >   1021  #endif
> >   1022                          (page->flags & check_flags)))
> >   1023                  return false;
> >   1024
> >   1025          return true;
> >   1026  }
> >
> > leads to
> >
> > 	mm/page_alloc.c:1019:1: error: directive in macro's argument list
> > 	mm/page_alloc.c:1021:1: error: directive in macro's argument list
>
> This does:
>
> 	/* Shut up warnings after an error */
> 	has_error |= ERROR_CURR_PHASE;
>
> so we probably end up not seeing some warnings.

Heh,

	./include/trace/events/neigh.h:127:1: error: directive in macro's argument list
	./include/trace/events/neigh.h:199:1: error: too many errors
	
so we probably end up not seeing some errors ;)

> > and it is not immediately clear why. Yes, because "unlikely" is a macro.
> >
> > Can't we simply remove this sparse_error() ? "#if" inside the macro's args
> > is widely used in kernel, gcc doesn't complain, afaics pre-process.c handles
> > this case correctly.
>
> s/correctly/the same as GCC/.  The behavior is undefined in c99.

Yes, yes, this is what I meant.

and just in case... there are other cases when GCC and sparse differ,

	if, within a macro invocation, that macro is redefined, then the new
	definition takes effect in time for argument pre-expansion, but the
	original definition is still used for argument replacement. Here is a
	pathological example:

		#define f(x) x x
		f (1
		#undef f
		#define f 2
		f)

	which expands to

		1 2 1 2

./sparse -E outputs

	/tmp/M.c:3:1: error: directive in macro's argument list
	/tmp/M.c:4:1: error: directive in macro's argument list
	2


but I think we don't care.

Oleg.
