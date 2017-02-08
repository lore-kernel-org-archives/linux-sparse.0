From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 0/8] fix uses of killed instructions
Date: Thu, 9 Feb 2017 04:40:07 +0800
Message-ID: <CANeU7Qkc1qShbgresJbRZbORuzzcMR28vPvv38kwFxHiE15ZLQ@mail.gmail.com>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
 <CAExDi1RJ8rPE7n7eGmBRnSe3FudW28HF7DkVErmVmniZrwSQJQ@mail.gmail.com> <20170208165055.ibu47j2axwi2j53f@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35384 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdBHUkI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Feb 2017 15:40:08 -0500
Received: by mail-io0-f180.google.com with SMTP id j18so196377ioe.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Feb 2017 12:40:08 -0800 (PST)
In-Reply-To: <20170208165055.ibu47j2axwi2j53f@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 9, 2017 at 12:50 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> So now that "fix value of label statement" is applied, you can
>> safely apply "fix killing of OP_SETVAL instructions" somewhere
>> after it, it won't create useless noise.
>
> I just noticed that you have added it at the top of sparse-next
> but what you applied (basically adding "case OP_SETVAL" in
> simplify_instruction()) is *not* what the patch I sent did
> (adding "case OP_SETVAL" in kill_instruction())s and causes
> quick crashes..
> I suppose there was a conflict or so.
>
> Do you want that I sent a new patch or can you solve it
> directly?

Strange. That is the only patch I found in my series.

Sure, go ahead and send me the new one. I will take out the
one in sparse-next and replace to your new one.

Chris
