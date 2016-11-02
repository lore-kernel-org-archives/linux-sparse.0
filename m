From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] ptrlist: use after free in last_ptr_list()
Date: Wed, 2 Nov 2016 22:52:35 +0800
Message-ID: <CANeU7Qk=Ta+QumF8BhSES9jTLDx+cdvvS8hfMQXg+B2H3Vfc-g@mail.gmail.com>
References: <20160613094517.GA25301@mwanda> <20161102124844.GA12544@macbook.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:34913 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbcKBOxa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 10:53:30 -0400
Received: by mail-it0-f54.google.com with SMTP id e187so85095778itc.0
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 07:53:29 -0700 (PDT)
In-Reply-To: <20161102124844.GA12544@macbook.home>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Nov 2, 2016 at 8:48 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> +     while (list->nr == 0)
>> +             list = list->prev;

Yes, it can deed loop here when the whole list is empty.

>                 FOR_EACH_PTR_REVERSE(list, ptr) {
>                         DELETE_CURRENT_PTR(ptr);
>                         last = last_ptr_list((struct ptr_list *)list);
>                 } END_FOR_EACH_PTR_REVERSE(ptr);
>         }
> loops forever on a list with 1 element with your patch.
> Without your patch, last_ptr_list() return an invalid pointer instead of NULL.
>

I can see what is going on now. The while loop should
check for the list->prev has been loop back to the tail of
the list.

Some thing like this should fix it, I haven't test it at all.

list = tail = list->prev;
while (list->nr == 0) {
     list = list->prev;
     if (list == tail)
           return NULL;
}

Chris
