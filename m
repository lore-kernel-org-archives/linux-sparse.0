From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] mark pseudo user as deleted instead of removing them
Date: Fri, 4 Aug 2017 14:19:54 -0400
Message-ID: <CANeU7Q=WRs47kXndEj6bPTJFUoVH211pAKwv3aV0Sx87oxZasA@mail.gmail.com>
References: <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804002230.5047-1-luc.vanoostenryck@gmail.com> <CANeU7Q=eNTqHRS__DPFnoOMH7vnUJHRh+3wCcFR-EF_SB7zmSA@mail.gmail.com>
 <CANeU7Q=Lsy+_5qBVGGBhK9ux5pJDVy6i0OTTsBoK=UCeSkTJhw@mail.gmail.com> <20170804155822.kr3bzd2amnxzqk76@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35477 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdHDSTz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 14:19:55 -0400
Received: by mail-pf0-f169.google.com with SMTP id t86so10799668pfe.2
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 11:19:55 -0700 (PDT)
In-Reply-To: <20170804155822.kr3bzd2amnxzqk76@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

First thing first, I don't have strong reason to object this patch.
So it can be merge into RC5.

On Fri, Aug 4, 2017 at 11:58 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Of course, it's why I said it wasn't very pretty.
>
> It is so for now because this patch only concerns lists
> with pseudo_users and only these lists need this check
> (and I certainly don't want to duplicate all the macros now).

OK. I see. As a minor point, (will not affect patch being accepted)
I want to make this into a part of the stander list.
And the "if (list->rm)" will make sure we only take the new code
path for pseudo_users. Because we only call to MARK_CURRENT_DELTE()
on pseudo_users.

Have two version of the API is confusing to the developer of sparse.
I would rather hind those temporary detail from the developer.
This ptr_list_size_null() is likely get remove from the next version of
sparse any way. So it would better not to expose it.


>
> There is only one case and it's to support an abuse of the list typing.
> I have a patch to have the clean typing (and thus no more null pointers in lists).
> Not -rc5 material IMO though.

Agree.

>
>> >  extern void concat_ptr_list(struct ptr_list *a, struct ptr_list **b);
>> >  extern void __free_ptr_list(struct ptr_list **);
>> >  extern int ptr_list_size(struct ptr_list *);
>> > +extern int ptr_list_size_null(struct ptr_list *);
>>
>> I don't think we need ptr_list_size_null vs ptr_list_size.
>
> Certainly true when all the lists will have been converted.
> Even true for the ones that doesn't but for the moment,
> as prototype to discuss the principle and to be sure to not
> introduce any changes else where, I've kept them separated.

I do not mean to convert all ptrlist. I am object to have two similar
api. If we do a test of "if (list->rm)", we can make sure only the
pseudo_user get the new code path. Because that is the only
ptrlist is going to mark ptrlist deleted and having list->rm != 0.

>
> Yes, details that will matter once we'll agree on the principle.

Principle is fine :-)

>
>> Why do we need two different version of pack_ptr_list?
>
> same as for ptr_list_size_null().

I see your reasoning was to reduce code impact.
I think the testing of (ptrlist->rm) can do the same thing.


>
>> If the ptrlist->rm != 0, that already means this ptrlist has been
>> used for mark deleted. Can we use just one pack_ptr_list instead?


I want to have one single API instead of two. As the code impact
caution, the "if (ptrlist->rm)" test will make sure only pseudo_user
list get the new code path.

Currently you use two different api function call to make sure
the new code don't impact other list. I mean to say you can do
the same with "if (ptrlist->rm)" testing.

Sparse also has usage as library for other projects.
Having some stable api is a good thing. I don't want a new temporary
API which get removed later if we can avoid it.

>
> Not sure to understand you here.

See above, hope I explain it clear enough.


>
>> Another thing is that, we might want to put some code
>> to assert in the ptrlist split and seeing ptrlist->rm != 0.
>
> OK, but again the goal of this patch is not about ptrlist split.
> It's only for the very specific case you found where there is a
> problem with deletion on pseudo-users lists. No more, no less.

OK, that is just a suggestion any way. Minor one.

>
>> Another thing I am thinking is weather this change too big for RC5.
>
> As such, I don't think it's a big change for -rc5, it's quite well
> contained to some very specific code.

If we are going to push this for RC5, can we have one set of API
for this case? I see reason not to introduce temporary API which
will get remove later.

Having the check for "if (list->rm)" and only add new code under
that condition will make sure enough we don't impact the other list
and old code?

> I agree that it would be natural to ask if we want a fix for this problem
> in the -rc5, though, as the problem have been there forever and nothing
> really bad has been discovered.

Fine with me.

> I would be fine with this patch (but it would need a bit more testing).
> I would be fine with no patch at all.
> I would be ok with your patch (the one with list duplication) but I
> think it's not a good one, even as a temporary bandaid (for the reasons
> I explained the first time I commented on it).

Fair enough. Yes. I can apply it. The question is, do you want to remove
the duplicate set of API? (by testing "list->rm").

Chris
