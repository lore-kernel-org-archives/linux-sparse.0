From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix expansion of constant bitfield dereference
Date: Mon, 21 Aug 2017 15:42:28 +0200
Message-ID: <CAMHZB6HJWjTycs9xm_j4WU+aF1W9mb4+9wTTNid-OdZDkUEigw@mail.gmail.com>
References: <20170820221602.27852-1-luc.vanoostenryck@gmail.com> <CANeU7Q=HgV-H0yRZ60n1A0uo79z+0F6mQEVxN8PQhQ_RQnB2NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38466 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbdHUNm3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 09:42:29 -0400
Received: by mail-ua0-f195.google.com with SMTP id d12so576259uag.5
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 06:42:29 -0700 (PDT)
In-Reply-To: <CANeU7Q=HgV-H0yRZ60n1A0uo79z+0F6mQEVxN8PQhQ_RQnB2NQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Mon, Aug 21, 2017 at 2:26 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Aug 20, 2017 at 6:16 PM, Luc Van Oostenryck wrote:
>
> With this applied, sparse still have a bug at did not match the
> value to the bit field member, right? I saw on the other email
> thread said the value always pick offset zero.

I'm not sure to understand.
Have you an example?

> Should I apply this as patch format or wait for it show up in a
> git pull request later?

Wait for the pull request, please.

>> --- a/expand.c
>> +++ b/expand.c
>> @@ -644,6 +644,8 @@ static int expand_dereference(struct expression *expr)
>>                 if (value) {
>>                         /* FIXME! We should check that the size is right! */
>>                         if (value->type == EXPR_VALUE) {
>> +                               if (is_bitfield_type(value->ctype))
>> +                                       return UNSAFE;
>
> You might want to consider move this outside of the EXPR_VALUE.
> I assume there is a bug in sparse matching the value to the member
> wrong, it could happen to EXPR_FVALUE as well.

Well ..., if we have an EXPR_FVALUE which type is a bitfield, yes
for sure there would be a bug. But I have no reason to belive there
is such bug and since checking the ctype is more costly than checking
the expr->type, I think it's best so.

Note, I find this check already annoying and hackish if not worse.

-- Luc
