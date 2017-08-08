From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 6/8] transform (A & M) >> S to (A >> S) & (M >> S)
Date: Mon, 7 Aug 2017 18:00:57 -0700
Message-ID: <CA+55aFyw=CN=RoEAVMFXc6qk=Y-hbuDvgN=thmyZTj1tSRxkhQ@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-7-luc.vanoostenryck@gmail.com>
 <CANeU7Q=VSGSTLweWegU1RxZO9_iV9UT0p9L5xe95rC6-vMuntA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37541 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdHHBA6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 21:00:58 -0400
Received: by mail-oi0-f65.google.com with SMTP id j194so1931417oib.4
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 18:00:57 -0700 (PDT)
In-Reply-To: <CANeU7Q=VSGSTLweWegU1RxZO9_iV9UT0p9L5xe95rC6-vMuntA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 5:22 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> Why (A>>S) & (M >>S) is easier to simplify?
>
> The original has two instruction but the result has three.

No, M and S are constants, so the end result also has just two ("lsr"
and "and").

And the simplified form has a smaller constant.

So I think that optimization makes a lot of sense.

It *might* result in further simplifications just because the final
'and' might be simpler, and even the "A >> S" might now be something
you can simplify (for example "A >> 16" could be turned into a 16-bit
load if the source of A is a 32-bit load).

But even in the absence of such further simplification, the smaller
constant thing likely makes it worth it. Almost all architectures have
an easier time with smaller constants, and doing

   (a >> 24) & 255;

is often noticeably more efficient than

   (a & 0xff000000) >> 24;

just because of the constant issue.

                Linus
