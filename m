From: Christopher Li <sparse@chrisli.org>
Subject: SSSA and some C pointer manipulation.
Date: Fri, 18 Aug 2017 22:46:13 -0400
Message-ID: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34949 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbdHSCqO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 22:46:14 -0400
Received: by mail-yw0-f180.google.com with SMTP id n83so40576670ywn.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 19:46:14 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

I have done the first round of reading your 29 patches.
It is actually very nice organized. Thanks for the effort
to make this review so easy to digest.

One thing I notices is that, if the use site is very far
from define, there are a lot of blocks in between. That
will cause a lot of possible phi node to be created.
That plus the ptrmap will have some memory allocation
over head. Might explain the 2% slow down.
Compare to classic way to convert to SSA. The expansive
part is doing the dominator tree. However that is mostly
read, very few write. The SSA is doing a lot of write
(creating phi node just in case it is needed.)

Another thing I just realized is that, this SSSA conversion
only works for *local* variable, not C pointers?
I want to construct some test source to verify.
However it is not even working for the base case:

================test 1.c=========
int a, b, c, d, e;

static void foo(void)
{
if (a)
b = c;
else
b = d;
if (c)
a = b;
if (b)
e = a;
}

for this test, none of the global variable access has
been promote to SSA. In this regard, it is different
in master. The master branch at least try to promote
a, b, c, d, e content pseudot to ssa.

This is from sssa-mini-v1
foo:
.L0:
<entry-point>
load.32     %r1 <- 0[a]
cbr         %r1, .L1, .L2

.L1:
load.32     %r2 <- 0[c]
store.32    %r2 -> 0[b]
br          .L3

.L2:
load.32     %r3 <- 0[d]
store.32    %r3 -> 0[b]
br          .L3

.L3:
load.32     %r4 <- 0[c]
cbr         %r4, .L4, .L5

.L4:
load.32     %r5 <- 0[b]
store.32    %r5 -> 0[a]
br          .L5

.L5:
load.32     %r6 <- 0[b]
cbr         %r6, .L6, .L8

.L6:
load.32     %r7 <- 0[a]
store.32    %r7 -> 0[e]
br          .L8

.L8:
ret

No phi at all.

============== test 2.c ==========
int a, c, d;

static int foo(void)
{
int b, e;
if (a)
b = c;
else
b = d;
if (c)
a = b;
if (b)
e = a;
return e;
}

static int foo_ptr(void)
{
int b, *bp = &b;
int e, *ep = &e;

if (a)
*bp = c;
else
*bp = d;
if (c)
a = *bp;
if (b)
e = a;
return e;
}
==============
There are two functions foo() and foo_ptr(),
The are exactly the same, except foo_ptr() is using
ptr to access the variable. The pointer is not used
for another other purpose.

You can see in the foo base, the variable b
has been promote to SSA. However, in foo_ptr()
the variable b has not been promote to SSA.

I look back the paper, the paper actually did not
discuss pointer at all. However pointer usage is
a big part of C. So in this regard, the previous master
branch actually try to promote the variable used by
pointers, because it first convert the symbol to symbol
address and using load and store to access them.

That I see as another big draw back the paper
haven't cover, (other than goto. ) The pointers.
It can't effectively deal with pointer because it
does not have the CFG yet. In that regard, this
series functionally is less than what is in the previous
master branch does. Given the previous master does
it incorrectly. I think fixing them wouldn't be much
bigger than what is needed for SSSA.

If we want to deal with pointer, I suspect it will need
to do more or less the SSSA paper  trying to avoid.
Do the CFG route and promote memory access to
pseudo. That means we can't remove that code in
patch 29 and also need to make it work as well.

Any idea how to make the above two test case
work?

Chris
