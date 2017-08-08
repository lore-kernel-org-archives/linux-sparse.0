From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 6/8] transform (A & M) >> S to (A >> S) & (M >> S)
Date: Mon, 7 Aug 2017 21:50:56 -0400
Message-ID: <CANeU7QnMbkx5txddPFBTcGq6Mcm5vcmum7sNqPFrU2W0micXBg@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-7-luc.vanoostenryck@gmail.com>
 <CANeU7Q=VSGSTLweWegU1RxZO9_iV9UT0p9L5xe95rC6-vMuntA@mail.gmail.com> <CA+55aFyw=CN=RoEAVMFXc6qk=Y-hbuDvgN=thmyZTj1tSRxkhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35668 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbdHHBu5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 21:50:57 -0400
Received: by mail-pf0-f180.google.com with SMTP id t86so8287320pfe.2
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 18:50:57 -0700 (PDT)
In-Reply-To: <CA+55aFyw=CN=RoEAVMFXc6qk=Y-hbuDvgN=thmyZTj1tSRxkhQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 9:00 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> But even in the absence of such further simplification, the smaller
> constant thing likely makes it worth it. Almost all architectures have
> an easier time with smaller constants, and doing
>
>    (a >> 24) & 255;
>
> is often noticeably more efficient than
>
>    (a & 0xff000000) >> 24;
>
> just because of the constant issue.

That totally make sense.

Thanks

Chris
