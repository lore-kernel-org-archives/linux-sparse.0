From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Thu, 6 Jul 2017 23:18:39 -0700
Message-ID: <CANeU7QmHW5MHKmEBf4ULeVyyHp4zue+errEw2ZB+y1P3Q8uLRQ@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com> <20170707060413.jmnflgn6kutugozb@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34313 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdGGGSl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 02:18:41 -0400
Received: by mail-pf0-f175.google.com with SMTP id q85so12247925pfq.1
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 23:18:41 -0700 (PDT)
In-Reply-To: <20170707060413.jmnflgn6kutugozb@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jul 6, 2017 at 11:04 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Jul 06, 2017 at 06:18:48PM -0700, Christopher Li wrote:
>> On Thu, Jul 6, 2017 at 5:40 PM, Christopher Li <sparse@chrisli.org> wrote:
>> Most noticablely remove_usage() inside of the  kill_use_list()
>> loop.
>
> Can you explain a bit what's wrong with this one?

Sure. Sorry I haven't be more specific.
The offending list in question is not the instruction list. It is the
pesudo->user list.

kill_use_list is iterate though p->user.
FOR_EACH_PTR(list, p) {
if (p == VOID)
continue;
kill_use(THIS_ADDRESS(p));
} END_FOR_EACH_PTR(p)


And remove_usage() is deleting the very same list
from with in the loop. That is the bug.

Basically, deleting entry from inner loop while outer loop
is going over the same list has the deleted entry[] sliding
forward problem. Cause the outer loop possible to skip some
entries.

It likely a different bug than the one you discover.
Your crash is likely cause by pack_ptr_list inside the
ptrlist loop. Which cause some pointer point to deleted
node.


I set a break point at die and get the back track as follows:
#0  die (fmt=fmt@entry=0x43e160 "%s:%d delete entry with %d parent
using ") at lib.c:204
#1  0x0000000000420a0f in delete_pseudo_user_list_entry
(list=list@entry=0x7ffff7f2e158, entry=entry@entry=0x7ffff7f72c28,
count=1)
    at simplify.c:175
#2  0x0000000000420d16 in remove_usage (usep=0x7ffff7f72c28,
p=0x7ffff7f2e150) at simplify.c:189
#3  kill_use (usep=0x7ffff7f72c28) at simplify.c:200
#4  kill_use_list (list=0x7ffff7f72c10) at simplify.c:210
#5  0x0000000000420bc9 in kill_insn (insn=insn@entry=0x7ffff7f36450,
force=force@entry=0) at simplify.c:249
#6  0x0000000000422244 in kill_instruction (insn=0x7ffff7f36450) at flow.h:32
#7  clean_up_phi (insn=0x7ffff7f36450) at simplify.c:162
#8  simplify_instruction (insn=insn@entry=0x7ffff7f36450) at simplify.c:1202
#9  0x000000000042015b in clean_up_one_instruction
(insn=0x7ffff7f36450, bb=0x7ffff7f3e5b0) at cse.c:45
#10 clean_up_insns (ep=0x7ffff7f56010) at cse.c:135
#11 cleanup_and_cse (ep=ep@entry=0x7ffff7f56010) at cse.c:366
#12 0x00000000004182e0 in linearize_fn (base_type=<optimized out>,
sym=0x7ffff7f56010) at linearize.c:2244
#13 linearize_symbol (sym=sym@entry=0x7ffff7f69490) at linearize.c:2286
#14 0x0000000000401139 in clean_up_symbols (list=0x7ffff7f6f510) at
test-linearize.c:49
#15 main (argc=<optimized out>, argv=<optimized out>) at test-linearize.c:62

Hope that helps.

Chris
