From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] mark pseudo user as deleted instead of removing them
Date: Fri, 4 Aug 2017 17:58:25 +0200
Message-ID: <20170804155822.kr3bzd2amnxzqk76@ltop.local>
References: <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804002230.5047-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=eNTqHRS__DPFnoOMH7vnUJHRh+3wCcFR-EF_SB7zmSA@mail.gmail.com>
 <CANeU7Q=Lsy+_5qBVGGBhK9ux5pJDVy6i0OTTsBoK=UCeSkTJhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36994 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbdHDP6c (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 11:58:32 -0400
Received: by mail-wm0-f42.google.com with SMTP id t201so23409025wmt.0
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 08:58:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=Lsy+_5qBVGGBhK9ux5pJDVy6i0OTTsBoK=UCeSkTJhw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 04, 2017 at 11:29:50AM -0400, Christopher Li wrote:
> > From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > Date: Thu, Aug 3, 2017 at 8:22 PM
> > Subject: [PATCH] mark pseudo user as deleted instead of removing them
> > To: Christopher Li <sparse@chrisli.org>
> > Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> >
> >
> > For discussion only.
...
> > @@ -283,6 +283,8 @@ void convert_instruction_target(struct instruction
> > *insn, pseudo_t src)
> >         if (target == src)
> >                 return;
> >         FOR_EACH_PTR(target->users, pu) {
> > +               if (!pu)
> > +                       continue;
> 
> I think this kind of the check should be put into FOR_EACH_PTR()

Of course, it's why I said it wasn't very pretty.

It is so for now because this patch only concerns lists
with pseudo_users and only these lists need this check
(and I certainly don't want to duplicate all the macros now).

> There is a few design choice here. We can make ptr==NULL for the condition
> of ptr is marked deleted. We can also use tags to do the marking. Using tags
> will allow NULL pointer as valid entry in the ptrlist.

It's a possibility indeed.
 
> I am still curious which ptrlist want to use NULL pointer as valid pointers.
> We might want to revisit that decision.

There is only one case and it's to support an abuse of the list typing.
I have a patch to have the clean typing (and thus no more null pointers in lists).
Not -rc5 material IMO though.

> >  extern void concat_ptr_list(struct ptr_list *a, struct ptr_list **b);
> >  extern void __free_ptr_list(struct ptr_list **);
> >  extern int ptr_list_size(struct ptr_list *);
> > +extern int ptr_list_size_null(struct ptr_list *);
> 
> I don't think we need ptr_list_size_null vs ptr_list_size.

Certainly true when all the lists will have been converted.
Even true for the ones that doesn't but for the moment,
as prototype to discuss the principle and to be sure to not
introduce any changes else where, I've kept them separated.

> Nobody care what was the ptr list size counting the deleted entry.
> We want the ptrlist size with valid entry only.

> > +#define DO_DELETE_CURRENT_NULL(__list, __nr) do {
> I think the name of the macro should more like DO_MARK_CURRENT_DELETED
> You can use PTR_ENTRY() here instead.
> MARK_CURRENT_DELETED()

Yes, details that will matter once we'll agree on the principle.
 
> Why do we need two different version of pack_ptr_list?

same as for ptr_list_size_null().

> If the ptrlist->rm != 0, that already means this ptrlist has been
> used for mark deleted. Can we use just one pack_ptr_list instead?

Not sure to understand you here.
 
> Another thing is that, we might want to put some code
> to assert in the ptrlist split and seeing ptrlist->rm != 0.

OK, but again the goal of this patch is not about ptrlist split.
It's only for the very specific case you found where there is a
problem with deletion on pseudo-users lists. No more, no less.

> Another thing I am thinking is weather this change too big for RC5.

As such, I don't think it's a big change for -rc5, it's quite well
contained to some very specific code.

I agree that it would be natural to ask if we want a fix for this problem
in the -rc5, though, as the problem have been there forever and nothing
really bad has been discovered.

I would be fine with this patch (but it would need a bit more testing).
I would be fine with no patch at all.
I would be ok with your patch (the one with list duplication) but I
think it's not a good one, even as a temporary bandaid (for the reasons
I explained the first time I commented on it).

-- Luc
