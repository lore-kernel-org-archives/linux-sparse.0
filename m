From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 10:19:34 +0100
Message-ID: <CACXZuxfoPyT65p46wZBN8=FMEgTwCeh3Y2P3Rc5KbYO39OK_xg@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <20170707054459.pkhqnmrz7yt3sppc@ltop.local> <CANeU7Q=6MZSn2Lm_+xhqrR1mU95Fq-j6oox8jEYqW+zW=UYTEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36562 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdGGJTh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 05:19:37 -0400
Received: by mail-wr0-f173.google.com with SMTP id c11so38142906wrc.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 02:19:36 -0700 (PDT)
In-Reply-To: <CANeU7Q=6MZSn2Lm_+xhqrR1mU95Fq-j6oox8jEYqW+zW=UYTEA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

On 7 July 2017 at 07:02, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Jul 6, 2017 at 10:44 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> The ptrlist is already fragile and now it would contains
>> yet another field that need to be taken care of *and* stay
>> coherent with other users. I doubt this will help to reduce bugs.
>>
> The reason ptrlist is fragile
> is we did not do it properly. Not safe against recursive ptr
> loop with inner loop delete stuff from the same list.
>

One of the first things I encountered when trying to get Sparse to
compile with MSVC was ptrlist as it uses some gcc only features. I
found it quite hard to follow the Macros so I attempted to reduce the
use of macros, and introduced the concept of iterators. So the macros
I use now look like below. I think this approach is easier to
understand and maintain. If you would like a patch for similar
implementation for Sparse then please let me know.

In general though - while a list is being traversed, deleting items
should be expected to work, as long as a ptrlist node is not deleted.
The reason is that an iterator is presumably on a particular node -
and if unknown to it the iterator is deleted, then it has no way to
continue. So maybe calling pack in the middle of an operation is
causing the problem?

Anyway - here is a snippet from my modified ptrlist implementation.

/* Each node in the list */
struct ptr_list {
int nr_;
struct ptr_list *prev_;
struct ptr_list *next_;
struct allocator *allocator_;
void *list_[LIST_NODE_NR];
};

struct ptr_list_iter {
struct ptr_list *__head;
struct ptr_list *__list;
int __nr;
};


#define FOR_EACH_PTR(list, var) \
{ struct ptr_list_iter var##iter__ = ptrlist_forward_iterator(list); \
for (var = ptrlist_iter_next(&var##iter__); var != NULL; var =
ptrlist_iter_next(&var##iter__))
#define FOR_EACH_PTR_TYPED(list, type, var) \
{ struct ptr_list_iter var##iter__ = ptrlist_forward_iterator(list); \
for (var = (type) ptrlist_iter_next(&var##iter__); var != NULL; var =
(type) ptrlist_iter_next(&var##iter__))
#define FOR_EACH_PTR_TYPE(list, var, ptr_type) \
{ struct ptr_list_iter var##iter__ = ptrlist_forward_iterator(list); \
for (var = (ptr_type) ptrlist_iter_next(&var##iter__); var != NULL;
var = (ptr_type) ptrlist_iter_next(&var##iter__))
#define END_FOR_EACH_PTR(var) }

#define FOR_EACH_PTR_REVERSE(list, var) \
{ struct ptr_list_iter var##iter__ = ptrlist_reverse_iterator(list); \
for (var = ptrlist_iter_prev(&var##iter__); var != NULL; var =
ptrlist_iter_prev(&var##iter__))
#define END_FOR_EACH_PTR_REVERSE(var) }

#define RECURSE_PTR_REVERSE(list, var) \
{ struct ptr_list_iter var##iter__ = list##iter__; \
for (var = ptrlist_iter_prev(&var##iter__); var != NULL; var =
ptrlist_iter_prev(&var##iter__))

#define PREPARE_PTR_LIST(list, var) \
struct ptr_list_iter var##iter__ = ptrlist_forward_iterator(list); \
var = ptrlist_iter_next(&var##iter__)

#define NEXT_PTR_LIST(var) \
var = ptrlist_iter_next(&var##iter__)
#define FINISH_PTR_LIST(var)

#define THIS_ADDRESS(type, var) \
(type *)ptrlist_iter_this_address(&var##iter__)

#define DELETE_CURRENT_PTR(var) \
ptrlist_iter_remove(&var##iter__)

#define REPLACE_CURRENT_PTR(type, var, replacement) \
ptrlist_iter_set(&var##iter__, replacement)

#define INSERT_CURRENT(newval, var) \
ptrlist_iter_insert(&var##iter__, newval)
