From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] llvm fixes
Date: Sun, 12 Nov 2017 18:10:05 +0800
Message-ID: <CANeU7Q=-450j8WC3ZDarOTqDUq2WcyHTgLf+XKbcZSCzD02jkg@mail.gmail.com>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qnu7h09YHhGVOY3r4M9FNOvOrs+kB_yJT-i0cSeLtKhAw@mail.gmail.com>
 <CANeU7QnFkJC4YePAdSTmKXNKiraCZHKJPSaNbKVPqdf01NhrYg@mail.gmail.com>
 <20171105171013.mktkihyuuagqthaq@ltop.local> <CANeU7QkXyUonK-wKjrGp_Ka6vBsFaJ65S3OvjMzLTKc8VUoW4w@mail.gmail.com>
 <CANeU7Q=qa4Je13z65nHa_V=QAC4w-30GiO3e72Lp5C49QYcDVg@mail.gmail.com> <CAExDi1SkKZ=dK_u7rPmwyhrL6t224u7HjevL5DszzSkEQDO+bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:56862 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbdKLKKG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Nov 2017 05:10:06 -0500
Received: by mail-yw0-f171.google.com with SMTP id r186so2833841ywe.13
        for <linux-sparse@vger.kernel.org>; Sun, 12 Nov 2017 02:10:06 -0800 (PST)
In-Reply-To: <CAExDi1SkKZ=dK_u7rPmwyhrL6t224u7HjevL5DszzSkEQDO+bA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 12, 2017 at 1:05 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> I think the PSEUDO_VAL being typeless is the problem here.
>
> And it has already been explained to you why they are typeless

And I already explain why your explain is wrong. You are using an
argument Linus used in the earlier email to re-battle the suggestion
make by Linus in the later email. You did not follow up on that email.
The ball is it your court. Do you want me to dig out the email archive?

> and why it's fine.

That is a design choice we can change. You haven't address that
if we choose other, what evil things can happen. Exactly, please
point to the PSEUDO_VAL with size patch and tell me what is evil
about that patch.

BTW, having the size is not the same as have the full type.

>> OP_PUSH:
>> - break sparse IR compatibility.
>
> What compatibility are you talking about?

Every one that write an application depend on the sparse
bytecode will need to update their source code how to handle the
OP_PUSH. You are forcing source code changes on other
projects.

>>
>> So far I see PSEUDO_VAL with size has advantage over
>> OP_PUSH. If I am wrong, please correct me, I am listening.
>
> The OP_PUSH solution has at least the advantage to work, to
> be integrated with all the other IR generation fixes and to be tested.

But the PSEUDO_VAL.size has the technical merit, it is a better
solution in long run. Of course we still need to be tested when it is
merged. That is given. It is not a reason to pick OP_PUSH over PSEUDO_VALE.size.

> You already came with this previously and I already replied you about it.
> I don't know what make you think that OP_PUSH are not in bb->insns
> but you're wrong: they are normal instructions and are thus stored
> in the bb->insns, the second patch even change their position inside
> this list.

Ok, fine. I retract the statement that OP_PUSH not in bb->insns.
But all other points still apply. With this new information.
PSEUDO_VALE.size still have technical merit over OP_PUSH.

Chris
