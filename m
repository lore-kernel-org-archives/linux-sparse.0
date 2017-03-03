From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] llvm: fix output_op_[ptr]cast()
Date: Fri, 3 Mar 2017 20:50:53 +0100
Message-ID: <CAExDi1RtFcCkdaWJ10o9p22BZcB5GcsbKmxCBDn5vMmkoBVZTg@mail.gmail.com>
References: <CACXZuxcd6q6c5VzsYME01nzUhKzLjzvxTDt3juSbNB226APTTg@mail.gmail.com>
 <20170303052459.2351-1-luc.vanoostenryck@gmail.com> <CACXZuxcN_5H+Ur53axpwbxy-LwQX2fANp5x6GUU-jU+7b4_2tw@mail.gmail.com>
 <CACXZuxd_gY9uaDHiCzq1TqRweeyp22ifWDDYZbYmjnMkGohenw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:32775 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdCCT7s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 14:59:48 -0500
Received: by mail-qk0-f177.google.com with SMTP id n127so194070791qkf.0
        for <linux-sparse@vger.kernel.org>; Fri, 03 Mar 2017 11:59:48 -0800 (PST)
In-Reply-To: <CACXZuxd_gY9uaDHiCzq1TqRweeyp22ifWDDYZbYmjnMkGohenw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Mar 3, 2017 at 7:06 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> The problem occurs in this sequence:
>
>        ptrcast.64  %r26 <- (64) %r20
>        add.64      %r27 <- %r26, %r23
>        cast.64     %r28 <- (64) %r27
>        store.64    %r28 -> 16[%arg1]
>
> The last cast finds that the instruction type in an integer and does a
> cast to Integer, so that causes the store to fail as it expects a
> pointer.

What is the corresponding C code?
With the patches I've posted, the three example you've given are handled
without error for me.

> Question in my mind is what is the result type of an add operation
> when one of the arguments is a pointer?

This should only occurs as some form of pointer arithmetic, so the result
should be some kind of pointer.

Luc
