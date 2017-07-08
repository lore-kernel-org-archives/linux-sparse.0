From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC 00/34] ptrlist rework with iterator
Date: Sat, 8 Jul 2017 08:13:15 -0700
Message-ID: <CANeU7Qkvy3BLVHszomvdY-SpSZ2A7TSgpofRW9D7Mji=LFub4Q@mail.gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33166 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752870AbdGHPNR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Jul 2017 11:13:17 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so7494772pgb.0
        for <linux-sparse@vger.kernel.org>; Sat, 08 Jul 2017 08:13:17 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jul 7, 2017 at 6:39 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Here is some patches reworking the whole ptrlist API
> which move all the logic currently present in the macros
> in a small set of primitive functions using an iterator
> structure.

I am not considering it for this release for sure.

Actually, NACK on the function based iterator API.

There is no much of a real function enhancement.
And it is a big slow down.

I actually like Linus' macro based implementation. I want
to keep it that way.

It looks very clean on the caller side. It perform extremely
fast. All the internal variable will easy promote to register.
I am all about using code to squeezing very last bit of performance
out of the hardware. The Linus' ptrlist does an amazing job.

Now the function based iterator:

The loop variable will have to keep in the struct member.
It does not inline well. On each function call, the compiler have
to sync loop variable into the memory based struct.
Take a look at the machine code it generated. It is no where
near as good as the original one. The benchmark confirms
that as well.

Here is the program just iterate over a long list for many times
with some condition testing inside the list item.

With Linus' ptrlist:
$ time ./test-ptrlist
sum 4992000000

real 0m9.071s
user 0m9.028s
sys 0m0.002s


Exactly same program with your iterator:
$ time ./test-ptrlist
sum 4992000000

real 0m31.601s
user 0m31.320s
sys 0m0.003s

That is 344% slow down. I have another test, for just the loop
iteration part with nop inside the loop. That is 10x speed difference.

Just make it out there, I am not willing to take a pure cosmetic
change with like 0.1% performance penalty. So NACK on this.

I feel sorry you have spent some many time on this. If I know
earlier I would have tell you that is not going to work. I actually
try that myself long time ago and find out Linus' ptrlist is very
hard to beat in terms of raw performance.


The git branh for this test prgram is at:

https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=test-ptrlist

Here is the test program. Sorry gmail cause some white space
damage to the code.

Chris


/*
 * sparse ptrlist abuse
 */
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <assert.h>

#include "lib.h"
#include "symbol.h"
#include "expression.h"
#include "linearize.h"
#include "flow.h"
#include "storage.h"
#include "target.h"



int main(int argc, char **argv)
{
struct string_list *filelist = NULL;
struct symbol_list *syms = NULL;
struct symbol *sym = (struct symbol *)0x10;
unsigned long sum = 0;

sparse_initialize(argc, argv, &filelist);
for (int i= 0; i < 10000; i++, sym++)
add_symbol(&syms, sym);

for (int i= 0; i < 100; i++) {
for (int j= 0; j < 10000; j++) {
FOR_EACH_PTR(syms, sym) {
if ((unsigned long) sym & 0x1000)
sum ++;
} END_FOR_EACH_PTR(sym);
}
}
printf("sum %ld\n", sum);
return 0;
}
