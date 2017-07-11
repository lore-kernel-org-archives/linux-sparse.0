From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Tue, 11 Jul 2017 13:53:36 -0700
Message-ID: <CANeU7Q=d_+QD+MSGyYqwL82M2RdC_AFVaeR-y87z3U3OKjNBKw@mail.gmail.com>
References: <CANeU7QmpvfZutvnSwrjH7ZYXhw3S3HDh19eHXkBGY7oz7ADtmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34750 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932595AbdGKUxs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Jul 2017 16:53:48 -0400
Received: by mail-pf0-f194.google.com with SMTP id c24so436324pfe.1
        for <linux-sparse@vger.kernel.org>; Tue, 11 Jul 2017 13:53:43 -0700 (PDT)
In-Reply-To: <CANeU7QmpvfZutvnSwrjH7ZYXhw3S3HDh19eHXkBGY7oz7ADtmw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

Ping, Any taker want to review or suggest alternative
way to fix the nested loop delete bug?

I will try the mark delete approach as well.  When to pack it is the tricky
part because the function might be call at different place. e.g.
parent in a ptrlist loop already vs not in a ptrlist loop.

I am just glad the ptrlist ref count patch did not reveal more
nesting loop delete offends. This pseudo->user list and ep->bbs
are the only two occasion the patch die on.

We might get away with do not pack the pseudo->users list at all.

Chris


On Mon, Jul 10, 2017 at 8:32 AM, Christopher Li <sparse@chrisli.org> wrote:
> I found a temporary solution is simple enough.
>
> Instead of marking the entry deleted. I just use a duplicate
> version of the list->list[] when doing the loop. It will have
> unwanted effect that iterator will issue some ptr are already
> deleted. Other than that, it is very straight forward.
>
> It pass the kernel compile test without issue different warnings.
> It also pass the ptrlist ref checking. The ref count patch can now
> complete the full kernel check without die() on it. Again no difference
> in warning.
>
> Chris
>
>
> From 18453b4b920ae53f25bc389609218d97e7f583a1 Mon Sep 17 00:00:00 2001
> From: Christopher Li <sparse@chrisli.org>
> Date: Mon, 10 Jul 2017 07:53:21 -0700
> Subject: [PATCH] Let pseudo->users loop on duplicate version of list
>
> pseudo->users list will change during find dominator.
> That cause a bug in the ptrlist because the outer loop iterator
> is not award of the deletion of the entry.
>
> Let the outer loop using a duplicate version of entry
> to avoid this problem for now.
>
> This is to fix the bug report by the ptrlist ref counting check.
> With this change, the ptrlist ref counting check can complete
> the kernel compile without reporting an error.
>
> Signed-of-By: Christopher Li <sparse@chrisli.org>
> ---
>  flow.c    |  7 ++++++-
>  ptrlist.h | 17 +++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/flow.c b/flow.c
> index fce8bde..2705448 100644
> --- a/flow.c
> +++ b/flow.c
> @@ -730,7 +730,12 @@ multi_def:
>  complex_def:
>  external_visibility:
>   all = 1;
> - FOR_EACH_PTR_REVERSE(pseudo->users, pu) {
> + /*
> + * FIXME: pseudo->users will have some entry deleted during looping.
> + * The loop will run on a duplicated version of the list entry for now.
> + * Should fix it properly later.
> + */
> + FOR_EACH_PTR_REVERSE_DUP(pseudo->users, pu) {
>   struct instruction *insn = pu->insn;
>   if (insn->opcode == OP_LOAD)
>   all &= find_dominating_stores(pseudo, insn, ++bb_generation, !mod);
> diff --git a/ptrlist.h b/ptrlist.h
> index d09be2f..5299ee5 100644
> --- a/ptrlist.h
> +++ b/ptrlist.h
> @@ -184,6 +184,20 @@ static inline void *last_ptr_list(struct ptr_list *list)
>   ptr = PTR_ENTRY(__list,__nr); \
>   do {
>
> +#define DO_FOR_EACH_REVERSE_DUP(head, ptr, __head, __list, __dup,
> __nr, PTR_ENTRY) do { \
> + struct ptr_list *__head = (struct ptr_list *) (head); \
> + struct ptr_list *__list = __head; \
> + CHECK_TYPE(head,ptr); \
> + if (__head) { \
> + do { int __nr; \
> + __list = __list->prev; \
> + __nr = __list->nr; \
> + struct ptr_list __dup; \
> + memcpy(__dup.list, __list->list, sizeof(ptr)*__nr); \
> + while (--__nr >= 0) { \
> + do { \
> + ptr = PTR_ENTRY(&__dup,__nr); \
> + do {
>
>  #define DO_END_FOR_EACH_REVERSE(ptr, __head, __list, __nr) \
>   } while (0); \
> @@ -231,6 +245,9 @@ static inline void *last_ptr_list(struct ptr_list *list)
>  #define FOR_EACH_PTR_REVERSE(head, ptr) \
>   DO_FOR_EACH_REVERSE(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY)
>
> +#define FOR_EACH_PTR_REVERSE_DUP(head, ptr) \
> + DO_FOR_EACH_REVERSE_DUP(head, ptr, __head##ptr, __list##ptr,
> __dup##ptr, __nr##ptr, PTR_ENTRY)
> +
>  #define END_FOR_EACH_PTR_REVERSE(ptr) \
>   DO_END_FOR_EACH_REVERSE(ptr, __head##ptr, __list##ptr, __nr##ptr)
>
> --
> 2.9.4
