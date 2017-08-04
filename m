From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] mark pseudo user as deleted instead of removing them
Date: Fri, 4 Aug 2017 11:29:50 -0400
Message-ID: <CANeU7Q=Lsy+_5qBVGGBhK9ux5pJDVy6i0OTTsBoK=UCeSkTJhw@mail.gmail.com>
References: <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804002230.5047-1-luc.vanoostenryck@gmail.com> <CANeU7Q=eNTqHRS__DPFnoOMH7vnUJHRh+3wCcFR-EF_SB7zmSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34549 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbdHDP3w (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 11:29:52 -0400
Received: by mail-pf0-f175.google.com with SMTP id o86so9231539pfj.1
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 08:29:52 -0700 (PDT)
In-Reply-To: <CANeU7Q=eNTqHRS__DPFnoOMH7vnUJHRh+3wCcFR-EF_SB7zmSA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

> From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Date: Thu, Aug 3, 2017 at 8:22 PM
> Subject: [PATCH] mark pseudo user as deleted instead of removing them
> To: Christopher Li <sparse@chrisli.org>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>
>
> For discussion only.
>
> This atch is also available in the git repository at:

Hah, that is very similar to one of my private patch attempt to use
ptrlist refcount
to make the delete right. Abandoned due to the insert case.

My ptrlist->deletes is your ptrlist->rm here.
https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/diff/ptrlist.h?h=ptrlist-refcount-clean


> @@ -283,6 +283,8 @@ void convert_instruction_target(struct instruction
> *insn, pseudo_t src)
>         if (target == src)
>                 return;
>         FOR_EACH_PTR(target->users, pu) {
> +               if (!pu)
> +                       continue;

I think this kind of the check should be put into FOR_EACH_PTR()
If you have ptr->rm && current ptr == NULL, then the ptr should be skipped.
In other words, it is a bug if the ptr->rm > 0 and ptr == NULL and ptr
is not skipped.
I can totally see some usage case some one forget to make that check.

There is a few design choice here. We can make ptr==NULL for the condition
of ptr is marked deleted. We can also use tags to do the marking. Using tags
will allow NULL pointer as valid entry in the ptrlist.

I am still curious which ptrlist want to use NULL pointer as valid pointers.
We might want to revisit that decision.

>  extern void concat_ptr_list(struct ptr_list *a, struct ptr_list **b);
>  extern void __free_ptr_list(struct ptr_list **);
>  extern int ptr_list_size(struct ptr_list *);
> +extern int ptr_list_size_null(struct ptr_list *);

I don't think we need ptr_list_size_null vs ptr_list_size.
Nobody care what was the ptr list size counting the deleted entry.
We want the ptrlist size with valid entry only.


>
> +#define DO_DELETE_CURRENT_NULL(__list, __nr) do {

I think the name of the macro should more like DO_MARK_CURRENT_DELETED

>          \
> +       void **__this = __list->list + __nr;
>          \
> +       *__this = NULL;

You can use PTR_ENTRY() here instead.

>          \
> +       __list->rm++;
>          \
> +} while (0)
> +
> +#define DELETE_CURRENT_PTR_NULL(ptr) \
> +       DO_DELETE_CURRENT_NULL(__list##ptr, __nr##ptr)
> +

MARK_CURRENT_DELETED()


>  #define REPLACE_CURRENT_PTR(ptr, new_ptr)
>                  \
>         do { *THIS_ADDRESS(ptr) = (new_ptr); } while (0)
>
>  extern void pack_ptr_list(struct ptr_list **);
> +extern void pack_ptr_list_null(struct ptr_list **);

Why do we need two different version of pack_ptr_list?
If the ptrlist->rm != 0, that already means this ptrlist has been
used for mark deleted. Can we use just one pack_ptr_list instead?

Another thing is that, we might want to put some code
to assert in the ptrlist split and seeing ptrlist->rm != 0.
ptrlist->rm !=0 means we do care about preserve the list->list[]
and list->nr. Ptrlist split will make some damage to that assumption.

Another thing I am thinking is weather this change too big for RC5.
This patch is very similar to mine after removing dependency of the
ptrlist refcount.

Chris
