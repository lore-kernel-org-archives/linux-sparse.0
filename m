From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 10:46:53 +0100
Message-ID: <CACXZuxd+uEx0yy=3fUjUPeJny56jR2M2w1H43=CQ3Gfm4iNqmw@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <20170707054459.pkhqnmrz7yt3sppc@ltop.local> <CANeU7Q=6MZSn2Lm_+xhqrR1mU95Fq-j6oox8jEYqW+zW=UYTEA@mail.gmail.com>
 <CACXZuxfoPyT65p46wZBN8=FMEgTwCeh3Y2P3Rc5KbYO39OK_xg@mail.gmail.com> <CANeU7QnVC=8tf2USfVf0hQex-uBpjWHXarQ44sUUtnVKg-jy_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33970 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdGGJqz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 05:46:55 -0400
Received: by mail-wr0-f171.google.com with SMTP id 77so39127785wrb.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 02:46:55 -0700 (PDT)
In-Reply-To: <CANeU7QnVC=8tf2USfVf0hQex-uBpjWHXarQ44sUUtnVKg-jy_A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 7 July 2017 at 10:44, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Jul 7, 2017 at 2:19 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> On 7 July 2017 at 07:02, Christopher Li <sparse@chrisli.org> wrote:
>>
>> Anyway - here is a snippet from my modified ptrlist implementation.
>>
>> /* Each node in the list */
>> struct ptr_list {
>> int nr_;
>> struct ptr_list *prev_;
>> struct ptr_list *next_;
>> struct allocator *allocator_;
>> void *list_[LIST_NODE_NR];
>> };
>>
>> struct ptr_list_iter {
>> struct ptr_list *__head;
>> struct ptr_list *__list;
>> int __nr;
>> };
>
> I try exactly that before.
>
> The problem with that is, it generate horrible code.
> I never able to teach gcc the member of the list_iter
> does not need to sync at memory boundary. I really
> want it to be register like.
>
>>
>> #define FOR_EACH_PTR(list, var) \
>> { struct ptr_list_iter var##iter__ = ptrlist_forward_iterator(list); \
>> for (var = ptrlist_iter_next(&var##iter__); var != NULL; var =
>> ptrlist_iter_next(&var##iter__))
>> #define FOR_EACH_PTR_TYPED(list, type, var) \
>> { struct ptr_list_iter var##iter__ = ptrlist_forward_iterator(list); \
>> for (var = (type) ptrlist_iter_next(&var##iter__); var != NULL; var =
>> (type) ptrlist_iter_next(&var##iter__))
>> #define FOR_EACH_PTR_TYPE(list, var, ptr_type) \
>> { struct ptr_list_iter var##iter__ = ptrlist_forward_iterator(list); \
>> for (var = (ptr_type) ptrlist_iter_next(&var##iter__); var != NULL;
>> var = (ptr_type) ptrlist_iter_next(&var##iter__))
>> #define END_FOR_EACH_PTR(var) }
>>
>> #define FOR_EACH_PTR_REVERSE(list, var) \
>> { struct ptr_list_iter var##iter__ = ptrlist_reverse_iterator(list); \
>> for (var = ptrlist_iter_prev(&var##iter__); var != NULL; var =
>> ptrlist_iter_prev(&var##iter__))
>> #define END_FOR_EACH_PTR_REVERSE(var) }
>
> The problem with this is that, once you put delete into mix.
> The iter will need to know which direction it need to go after
> the delete. It is actually very messy.
>
>  I end up abandon that approach.

I am using this without problems in dmr_C so not sure I understand why
it did not work.

Regards
Dibyendu
