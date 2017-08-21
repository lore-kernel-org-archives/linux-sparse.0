From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH] fix expansion of constant bitfield dereference
Date: Mon, 21 Aug 2017 14:32:35 +0100
Message-ID: <CACXZuxcLv_W_FSq9nUrRO-5SsR1pGJ7U-xX4w_-6jLBLaJpuww@mail.gmail.com>
References: <20170820221602.27852-1-luc.vanoostenryck@gmail.com> <CANeU7Q=HgV-H0yRZ60n1A0uo79z+0F6mQEVxN8PQhQ_RQnB2NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:37027 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753854AbdHUNcg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 09:32:36 -0400
Received: by mail-vk0-f65.google.com with SMTP id r199so6596616vke.4
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 06:32:36 -0700 (PDT)
In-Reply-To: <CANeU7Q=HgV-H0yRZ60n1A0uo79z+0F6mQEVxN8PQhQ_RQnB2NQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 21 August 2017 at 13:26, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Aug 20, 2017 at 6:16 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> During the expansion of a dereference, it's if the initializer
>> which corrrespond to the offset we're interested is a constant.
>> In which case this dereference can be avoided and the value
>> given in the initializer can be used instead.
>>
>> However, it's not enough to check for the offset since for bitfields
>> several are placed at the same offset.
>> Currently, the first initializer matching the offset is selected.
>>
>> Fix this by refusing such expansion if the constant value correspond
>> to a bitfield.
>>
>
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
>

Since a bitfield is always integer and this issue is occurring with
bitfields, then I guess this change is correct?

Regards
Dibyendu
