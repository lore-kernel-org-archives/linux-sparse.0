From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] use VOID instead of directly using &void_pseudo
Date: Mon, 27 Feb 2017 22:23:14 +0100
Message-ID: <CAExDi1S3_sUZPB3zMzzdQKM33UJaVbvOU2YHFTnFhJXUYEcfEg@mail.gmail.com>
References: <20170220104536.12105-1-luc.vanoostenryck@gmail.com> <CANeU7Q=VUj_deEkgopRXAEAsKtgkP3i_Kd6SzE15t+yjCse6Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36378 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdB0VdS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 16:33:18 -0500
Received: by mail-qk0-f193.google.com with SMTP id r90so20192051qki.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 13:31:34 -0800 (PST)
In-Reply-To: <CANeU7Q=VUj_deEkgopRXAEAsKtgkP3i_Kd6SzE15t+yjCse6Yg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Feb 27, 2017 at 4:40 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Feb 20, 2017 at 6:45 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> diff --git a/linearize.c b/linearize.c
>> index 99203d915..6908e9f57 100644
>> --- a/linearize.c
>> +++ b/linearize.c
>> @@ -1862,7 +1862,7 @@ static pseudo_t linearize_return(struct entrypoint *ep, struct statement *stmt)
>>         struct basic_block *active;
>>         pseudo_t src = linearize_expression(ep, expr);
>>         active = ep->active;
>> -       if (active && src != &void_pseudo) {
>> +       if (active && src != VOID) {
>
> Looks good.  Can you add S-O-B for this?
>
> Thanks

Sure.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
