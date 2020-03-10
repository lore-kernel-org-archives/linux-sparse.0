From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] Add symantic index utility
Date: Tue, 10 Mar 2020 16:07:14 +0100
Message-ID: <20200310150713.GB19012@redhat.com>
References: <20200309152509.6707-1-gladkov.alexey@gmail.com>
 <20200309223701.dbnej7esb4qp56bm@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48703 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726825AbgCJPHT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 10 Mar 2020 11:07:19 -0400
In-Reply-To: <20200309223701.dbnej7esb4qp56bm@ltop.local>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On 03/09, Luc Van Oostenryck wrote:
>
> On Mon, Mar 09, 2020 at 04:25:09PM +0100, Alexey Gladkov wrote:
> > sindex is the simple to use cscope-like tool based on sparse/dissect.
> > Unlike cscope it runs after pre-processor and thus it can't index the
> > code filtered out by ifdef's, but otoh it understands how the symbol
> > is used and it can track the usage of struct members.
>
> Hi,
>
> This looks pretty good.
> I just have a few non-essential remarks I've added here below.

Great, thanks!

while Alexey is working on your comments...

> > To create an index for your linux kernel configuration:
> >
> > $ make C=2 CHECK="sindex add --"

Annoyingly, this triggers a lot of sparse_error's in pre-process.c:collect_arg().
And just in case, of course this is not specific to dissect/sindex, ./sparse or
anything else will equally complain.

For example,

  1011  static inline bool page_expected_state(struct page *page,
  1012                                          unsigned long check_flags)
  1013  {
  1014          if (unlikely(atomic_read(&page->_mapcount) != -1))
  1015                  return false;
  1016
  1017          if (unlikely((unsigned long)page->mapping |
  1018                          page_ref_count(page) |
  1019  #ifdef CONFIG_MEMCG
  1020                          (unsigned long)page->mem_cgroup |
  1021  #endif
  1022                          (page->flags & check_flags)))
  1023                  return false;
  1024
  1025          return true;
  1026  }

leads to

	mm/page_alloc.c:1019:1: error: directive in macro's argument list
	mm/page_alloc.c:1021:1: error: directive in macro's argument list

and it is not immediately clear why. Yes, because "unlikely" is a macro.

Can't we simply remove this sparse_error() ? "#if" inside the macro's args
is widely used in kernel, gcc doesn't complain, afaics pre-process.c handles
this case correctly.

With the patch below

	$ make -s -j4 C=2 CHECK='sindex add --'

in my dev tree is really silent:

	kernel/events/core.c:571:26: warning: function 'perf_pmu_name' with external linkage has definition
	arch/x86/kernel/kprobes/opt.c:468:13: warning: function 'arch_unoptimize_kprobes' with external linkage has definition

and both warnings look valid.

Oleg.

--- a/pre-process.c
+++ b/pre-process.c
@@ -271,8 +271,6 @@ static struct token *collect_arg(struct token *prev, int vararg, struct position
 	while (!eof_token(next = scan_next(p))) {
 		if (next->pos.newline && match_op(next, '#')) {
 			if (!next->pos.noexpand) {
-				sparse_error(next->pos,
-					     "directive in macro's argument list");
 				preprocessor_line(stream, p);
 				__free_token(next);	/* Free the '#' token */
 				continue;
