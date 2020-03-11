From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Add symantic index utility
Date: Wed, 11 Mar 2020 12:07:45 +0300
Message-ID: <20200311090745.GD11561@kadam>
References: <20200309152509.6707-1-gladkov.alexey@gmail.com>
 <20200309223701.dbnej7esb4qp56bm@ltop.local>
 <20200310150713.GB19012@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:40856 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgCKJH6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 11 Mar 2020 05:07:58 -0400
Content-Disposition: inline
In-Reply-To: <20200310150713.GB19012@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Tue, Mar 10, 2020 at 04:07:14PM +0100, Oleg Nesterov wrote:
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

This does:

	/* Shut up warnings after an error */
	has_error |= ERROR_CURR_PHASE;

so we probably end up not seeing some warnings.

> 
> and it is not immediately clear why. Yes, because "unlikely" is a macro.
> 
> Can't we simply remove this sparse_error() ? "#if" inside the macro's args
> is widely used in kernel, gcc doesn't complain, afaics pre-process.c handles
> this case correctly.

s/correctly/the same as GCC/.  The behavior is undefined in c99.

regards,
dan carpenter
