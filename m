From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] ptrlist: use after free in last_ptr_list()
Date: Wed, 2 Nov 2016 16:23:10 +0100
Message-ID: <20161102152309.GA13632@macpro.local>
References: <20160613094517.GA25301@mwanda>
 <20161102124844.GA12544@macbook.home>
 <CANeU7Qk=Ta+QumF8BhSES9jTLDx+cdvvS8hfMQXg+B2H3Vfc-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36618 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754587AbcKBPXO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 11:23:14 -0400
Received: by mail-wm0-f48.google.com with SMTP id p190so275661750wmp.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 08:23:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qk=Ta+QumF8BhSES9jTLDx+cdvvS8hfMQXg+B2H3Vfc-g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Nov 02, 2016 at 10:52:35PM +0800, Christopher Li wrote:
> On Wed, Nov 2, 2016 at 8:48 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> +     while (list->nr == 0)
> >> +             list = list->prev;
> 
> Yes, it can deed loop here when the whole list is empty.
> 
> >                 FOR_EACH_PTR_REVERSE(list, ptr) {
> >                         DELETE_CURRENT_PTR(ptr);
> >                         last = last_ptr_list((struct ptr_list *)list);
> >                 } END_FOR_EACH_PTR_REVERSE(ptr);
> >         }
> > loops forever on a list with 1 element with your patch.
> > Without your patch, last_ptr_list() return an invalid pointer instead of NULL.
> >
> 
> I can see what is going on now. The while loop should
> check for the list->prev has been loop back to the tail of
> the list.
> 
> Some thing like this should fix it, I haven't test it at all.
> 
> list = tail = list->prev;
> while (list->nr == 0) {
>      list = list->prev;
>      if (list == tail)
>            return NULL;
> }
> 
> Chris
> --

Yes, something like this should do, indeed.
But by looking at the code, I think that 'first_ptr_list()'
is also not immunised against the same problem.

Also these two functions first_ & last_ptr_list() were
trivial ones but now they maybe become a bit too heavy to be inlined?

Or, maybe we should create a 'safe' version of those two, not inlined,
and which do the correct list walking?
Or maybe we need to have a macro like LAST_PTR() which do everything needed,
like DELETE_CURRENT_PTR() do?

I would vote for the safe version.

Luc
