From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] llvm fixes
Date: Sun, 12 Nov 2017 06:05:15 +0100
Message-ID: <CAExDi1SkKZ=dK_u7rPmwyhrL6t224u7HjevL5DszzSkEQDO+bA@mail.gmail.com>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qnu7h09YHhGVOY3r4M9FNOvOrs+kB_yJT-i0cSeLtKhAw@mail.gmail.com>
 <CANeU7QnFkJC4YePAdSTmKXNKiraCZHKJPSaNbKVPqdf01NhrYg@mail.gmail.com>
 <20171105171013.mktkihyuuagqthaq@ltop.local> <CANeU7QkXyUonK-wKjrGp_Ka6vBsFaJ65S3OvjMzLTKc8VUoW4w@mail.gmail.com>
 <CANeU7Q=qa4Je13z65nHa_V=QAC4w-30GiO3e72Lp5C49QYcDVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:52204 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdKLFFQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Nov 2017 00:05:16 -0500
Received: by mail-it0-f46.google.com with SMTP id x28so235275ita.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 21:05:16 -0800 (PST)
In-Reply-To: <CANeU7Q=qa4Je13z65nHa_V=QAC4w-30GiO3e72Lp5C49QYcDVg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 12, 2017 at 2:04 AM, Christopher Li <sparse@chrisli.org> wrote:
> OK, this is the most difficult review for me to write, the OP_PUSH patch:
> I have think this long and hard.
>
>>commit 92fed40628f932a20a6cc95a67e4e5b03d280757
>>Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>>Date:   Fri Mar 17 11:49:42 2017 +0100
>>
>>    give function's arguments a type via OP_PUSH
>>
>>    The linearized code, sparse's IR, have no use of C's complex type
>>    system. Those types are checked in previous phases and the pseudos
>>    doesn't a type directly attached to them as all needed type info
>>    are now conveyed by the instructions (like (register) size,
>>    signedness (OP_DIVU vs OP_DIVS), ...).
>>
>>    In particular, PSEUDO_VAL (used for integer and address constants)
>>    are completely typeless.
>
> I think the PSEUDO_VAL being typeless is the problem here.

And it has already been explained to you why they are typeless
and why it's fine.

>
> OP_PUSH:
> - break sparse IR compatibility.

What compatibility are you talking about?

>
> So far I see PSEUDO_VAL with size has advantage over
> OP_PUSH. If I am wrong, please correct me, I am listening.

The OP_PUSH solution has at least the advantage to work, to
be integrated with all the other IR generation fixes and to be tested.

-- Luc
