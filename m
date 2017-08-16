From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 11:40:15 +0100
Message-ID: <CACXZuxfHwxUHWFhjQaux7W_d=tOmLMhty6-FyLFnjoeLYDOq5w@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
 <CA+55aFzvNEGEbO=H9C5q29js7A57zMm00a8i5NqDfPsZAxpr2g@mail.gmail.com>
 <CANeU7Qmq8N7Bqg0pWNONC8NkZ5J7p07B+UPBB-0eF9dTAOBYYg@mail.gmail.com> <CANeU7Qm05_jY3tx=eBYshciwe=zaHm55qrGAre07zwk6R=m4Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36989 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdHPKkQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 06:40:16 -0400
Received: by mail-vk0-f52.google.com with SMTP id r199so10775391vke.4
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 03:40:16 -0700 (PDT)
In-Reply-To: <CANeU7Qm05_jY3tx=eBYshciwe=zaHm55qrGAre07zwk6R=m4Eg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 16 August 2017 at 05:58, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Aug 16, 2017 at 12:23 AM, Christopher Li <sparse@chrisli.org> wrote:
>> If sparse only place the phi node on where the loads are, which a lot of
>> case happen to be the DF (dominance frontier). In the case that DF
>> does not have loads, that is where current sparse do wrong, sparse
>> does not place a phi node  there. Which violate the SSA property.
>
> I give an example for the above situation I am talking about:
>
> int a, b, c, d;
>
> void foo(void)
> {
>   int e, f;
>   if (a)
>      e = b;
>   else
>      e = c;
>   if (b)
>      c = a+b;
>   d = e;
> }
>
> "if (b)" is where the dominance of "e = b" and "e =c" joined.
> I don't do any loading of "e" there.
> To insert some blocks before using "e", I use the "if (b)".
>

> Now let's look at the test-linearize output:

I think the linear output you obtained was post simplification. We
need to look at the output prior to any simplifications. I believe it
looks like this:

foo:
.L0:
        <entry-point>
        load.32     %r1 <- 0[a]
        cbr         %r1, .L1, .L2

.L1:
        load.32     %r2 <- 0[b]
        store.32    %r2 -> 0[e]
        br          .L3

.L2:
        load.32     %r3 <- 0[c]
        store.32    %r3 -> 0[e]
        br          .L3

.L3:
        load.32     %r4 <- 0[b]
        cbr         %r4, .L4, .L5

.L4:
        load.32     %r5 <- 0[a]
        load.32     %r6 <- 0[b]
        add.32      %r7 <- %r5, %r6
        store.32    %r7 -> 0[c]
        br          .L5

.L5:
        load.32     %r8 <- 0[e]
        store.32    %r8 -> 0[d]
        br          .L6

.L6:
        ret

And here is the output from the new SSA construction:

foo:
.L0:
        <entry-point>
        load.32     %r1 <- 0[a]
        cbr         %r1, .L1, .L2

.L1:
        load.32     %r2 <- 0[b]
        phisrc.32   %phi1(e) <- %r2
        br          .L3

.L2:
        load.32     %r3 <- 0[c]
        phisrc.32   %phi2(e) <- %r3
        br          .L3

.L3:
        phi.32      %r9(e) <- %phi1(e), %phi2(e)
        load.32     %r4 <- 0[b]
        cbr         %r4, .L4, .L5

.L4:
        load.32     %r5 <- 0[a]
        load.32     %r6 <- 0[b]
        add.32      %r7 <- %r5, %r6
        store.32    %r7 -> 0[c]
        br          .L5

.L5:
        store.32    %r9(e) -> 0[d]
        br          .L6

.L6:
        ret

Finally here is what clang does after some phases (initially clang
starts with local vars).

*** IR Dump After SROA ***
; Function Attrs: nounwind
define void @foo() #0 {
entry:
  %0 = load i32, i32* @a, align 4, !tbaa !1
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load i32, i32* @b, align 4, !tbaa !1
  br label %if.end

if.else:                                          ; preds = %entry
  %2 = load i32, i32* @c, align 4, !tbaa !1
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %e.0 = phi i32 [ %1, %if.then ], [ %2, %if.else ]
  %3 = load i32, i32* @b, align 4, !tbaa !1
  %tobool1 = icmp ne i32 %3, 0
  br i1 %tobool1, label %if.then2, label %if.end3

if.then2:                                         ; preds = %if.end
  %4 = load i32, i32* @a, align 4, !tbaa !1
  %5 = load i32, i32* @b, align 4, !tbaa !1
  %add = add nsw i32 %4, %5
  store i32 %add, i32* @c, align 4, !tbaa !1
  br label %if.end3

if.end3:                                          ; preds = %if.then2, %if.end
  store i32 %e.0, i32* @d, align 4, !tbaa !1
  ret void
}

Regards
Dibyendu
