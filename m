From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 00:58:53 -0400
Message-ID: <CANeU7Qm05_jY3tx=eBYshciwe=zaHm55qrGAre07zwk6R=m4Eg@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
 <CA+55aFzvNEGEbO=H9C5q29js7A57zMm00a8i5NqDfPsZAxpr2g@mail.gmail.com> <CANeU7Qmq8N7Bqg0pWNONC8NkZ5J7p07B+UPBB-0eF9dTAOBYYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33423 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbdHPE6z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 00:58:55 -0400
Received: by mail-yw0-f180.google.com with SMTP id p68so16358530ywg.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 21:58:54 -0700 (PDT)
In-Reply-To: <CANeU7Qmq8N7Bqg0pWNONC8NkZ5J7p07B+UPBB-0eF9dTAOBYYg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 16, 2017 at 12:23 AM, Christopher Li <sparse@chrisli.org> wrote:
> If sparse only place the phi node on where the loads are, which a lot of
> case happen to be the DF (dominance frontier). In the case that DF
> does not have loads, that is where current sparse do wrong, sparse
> does not place a phi node  there. Which violate the SSA property.

I give an example for the above situation I am talking about:

int a, b, c, d;

void foo(void)
{
  int e, f;
  if (a)
     e = b;
  else
     e = c;
  if (b)
     c = a+b;
  d = e;
}

"if (b)" is where the dominance of "e = b" and "e =c" joined.
I don't do any loading of "e" there.
To insert some blocks before using "e", I use the "if (b)".

Now let's look at the test-linearize output:
foo:
.L0:
<entry-point>
load.32     %r1(a) <- 0[a]
cbr         %r1(a), .L1, .L2

.L1:
load.32     %r2(e) <- 0[b]
phisrc.32   %phi3(b) <- %r2(e)
phisrc.32   %phi4(e) <- %r2(e)
phisrc.32   %phi6(e) <- %r2(e)
phisrc.32   %phi7(e) <- %r2(e)
br          .L3

.L2:
load.32     %r3 <- 0[c]
phisrc.32   %phi5(e) <- %r3
br          .L3

.L3:
load.32     %r4(b) <- 0[b] <========  notice no phi node here.
          It is required because here it knows which edge
          it arrived. From L1, use %r2, from L2 use %r3.


cbr         %r4(b), .L4, .L5

.L4:
add.32      %r7 <- %r1(a), %r4(b)
store.32    %r7 -> 0[c]
br          .L5

.L5:
phi.32      %r8 <- %phi4(e), %phi5(e) <====== phi node here
store.32    %r8 -> 0[d]
ret

Notice how phi node is too late in .L5.

L5 does not have the edge information how
L1 and L2 joined. That information is at L3.

The phi source is not going to remedy this.
Because phi source is not going to know how
the phi source is going to join other phi source in
the later blocks.

The edge information is the one that is critically
missing here.

Actually, if we do SSA properly, we don't need the
phi source at all. We can directly use the source of
the phisource, which is %r2 and %r3.
if arrive in L3 from L1 use %r2, from L2 using %r3.


Chris
