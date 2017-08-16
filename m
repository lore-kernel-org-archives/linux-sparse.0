From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 09:17:23 -0400
Message-ID: <CANeU7Qnqgkci=a8uXxZaPvnYsGAYQ3u=LzV80iqyMpTVw8spoA@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
 <CA+55aFzvNEGEbO=H9C5q29js7A57zMm00a8i5NqDfPsZAxpr2g@mail.gmail.com>
 <CANeU7Qmq8N7Bqg0pWNONC8NkZ5J7p07B+UPBB-0eF9dTAOBYYg@mail.gmail.com>
 <CANeU7Qm05_jY3tx=eBYshciwe=zaHm55qrGAre07zwk6R=m4Eg@mail.gmail.com> <CACXZuxfHwxUHWFhjQaux7W_d=tOmLMhty6-FyLFnjoeLYDOq5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33983 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbdHPNRZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 09:17:25 -0400
Received: by mail-yw0-f169.google.com with SMTP id s143so22265193ywg.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 06:17:25 -0700 (PDT)
In-Reply-To: <CACXZuxfHwxUHWFhjQaux7W_d=tOmLMhty6-FyLFnjoeLYDOq5w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 16, 2017 at 6:40 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:

> I think the linear output you obtained was post simplification. We
> need to look at the output prior to any simplifications. I believe it
> looks like this:

Before prompting memory variable to SSA form, the SSA form
is correct.  That is my currently understanding. The incorrect SSA
form happen when we promote the memory variable into pseudo.

> Finally here is what clang does after some phases (initially clang
> starts with local vars).
>
> *** IR Dump After SROA ***
> ; Function Attrs: nounwind
> define void @foo() #0 {
> entry:
>   %0 = load i32, i32* @a, align 4, !tbaa !1
>   %tobool = icmp ne i32 %0, 0
>   br i1 %tobool, label %if.then, label %if.else
>
> if.then:                                          ; preds = %entry
>   %1 = load i32, i32* @b, align 4, !tbaa !1
>   br label %if.end
>
> if.else:                                          ; preds = %entry
>   %2 = load i32, i32* @c, align 4, !tbaa !1
>   br label %if.end
>
> if.end:                                           ; preds = %if.else, %if.then
>   %e.0 = phi i32 [ %1, %if.then ], [ %2, %if.else ] <================

Notice how clang place the phi node at where I said it
need to be, basically the L3 in my email.

Also notice clang does not have phi source. It don't need to.


Chris
