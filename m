From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] fix casts when linearizing compound assignments
Date: Sat, 16 Jun 2012 02:10:37 -0400
Message-ID: <DAA1FCCC-E2A7-4004-9BEE-CBB8A6C3104C@gmail.com>
References: <1339152460-17411-1-git-send-email-xi.wang@gmail.com> <56898225-DCA7-465E-BFD8-7D9D084A243B@gmail.com> <CAOJsxLEQhzNe2RNKW3RkDNkLbu3cszJfW0KzRq4oNRVaRXoP5Q@mail.gmail.com> <4FD25BB2.2030300@garzik.org> <CA+55aFyCihY76wE=cq6aw9LGG9Jc9U=R9VjTZc5sJM26k11-cw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:32871 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab2FPGKr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 Jun 2012 02:10:47 -0400
Received: by obbtb18 with SMTP id tb18so5067033obb.19
        for <linux-sparse@vger.kernel.org>; Fri, 15 Jun 2012 23:10:46 -0700 (PDT)
In-Reply-To: <CA+55aFyCihY76wE=cq6aw9LGG9Jc9U=R9VjTZc5sJM26k11-cw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>

On Jun 8, 2012, at 4:16 PM, Linus Torvalds wrote:
> 
> Looking at the LLVM API docs that Xi referred to, the LLVM preference
> is actually pretty weak.
> 
> So I'd almost say continue with the current IR, and just do the
> pointer arithmetic by hand. If LLVM doesn't treat GEP *that*
> specially, doing a separate pointer arithmetic level is quite possibly
> going to just cause problems: simplification of combinations of GEP
> and arithmetic is potentially quite annoying and has problems that
> simplification of perfectly regular addition does not.

I tried a simple strategy to emit an offset:

1) cast the pointer to i8* (char*);

2) emit GEP with the offset computed by sparse;

3) cast the pointer back to its original type.

There is no pointer-integer conversion at all.  This seems to work
well with both current IR and LLVM's optimizer.

Here are some examples, using my experimental backend "splay".

  struct X { int a, b; };

  void szero(struct X *x)
  {
    x->a = 0;
    x->b = 0;
  }

splay (with opt -O2) emits:

  %0 = getelementptr inbounds %struct.X* %x, i64 0, i32 0
  store i32 0, i32* %0, align 4
  %1 = getelementptr inbounds %struct.X* %x, i64 0, i32 1
  store i32 0, i32* %1, align 4

LLVM's optimizer is even able to "recover" GEP x, 0, 1 for x->b,
from what splay (without opt) actually emits:

  %4 = bitcast %struct.X* %x to i32*
  %5 = bitcast i32* %4 to i8*
  %6 = getelementptr inbounds i8* %5, i64 4

Here's an example of variable offset.

  void izero(int *x, size_t n)
  {
    x[n] = 0;
  }

splay (with opt -O2) emits:

  %0 = shl nsw i64 %n, 2
  %1 = bitcast i32* %x to i8*
  %2 = getelementptr inbounds i8* %1, i64 %0
  %3 = bitcast i8* %2 to i32*
  store i32 0, i32* %3, align 4

This time the result doesn't look as perfect as Clang, which emits
GEP %x, %n, but the assembly code is the same:

  movl  $0, (%rdi,%rsi,4)

Here goes a more complex one.

  void azero(int *x, size_t n)
  {
    size_t i;

    for (i = 0; i != n; ++i)
      x[i] = 0;
  }

splay (with opt -O2) emits:

  ...
  %1 = bitcast i32* %x to i8*
  %2 = shl i64 %n, 2
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 %2, i32 4, i1 false)
  ...

LLVM's optimizer recognizes the in-loop GEP and rewrites the whole
thing using memset.

- xi

