From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix expansion of constant bitfield dereference
Date: Mon, 21 Aug 2017 09:41:44 -0400
Message-ID: <CANeU7Q=oR2GA4CP95t+1bLRKOUkFhOH+8YkKXFP+Xrk6h9UECA@mail.gmail.com>
References: <20170820221602.27852-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=HgV-H0yRZ60n1A0uo79z+0F6mQEVxN8PQhQ_RQnB2NQ@mail.gmail.com> <CACXZuxcLv_W_FSq9nUrRO-5SsR1pGJ7U-xX4w_-6jLBLaJpuww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33051 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753684AbdHUNlp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 09:41:45 -0400
Received: by mail-yw0-f175.google.com with SMTP id h127so23083540ywf.0
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 06:41:45 -0700 (PDT)
In-Reply-To: <CACXZuxcLv_W_FSq9nUrRO-5SsR1pGJ7U-xX4w_-6jLBLaJpuww@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 21, 2017 at 9:32 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>> You might want to consider move this outside of the EXPR_VALUE.
>> I assume there is a bug in sparse matching the value to the member
>> wrong, it could happen to EXPR_FVALUE as well.
>>
>
> Since a bitfield is always integer and this issue is occurring with
> bitfields, then I guess this change is correct?

Ok, I forget about that. You are absolutely. right.

Never mind that comment then.

Chris
