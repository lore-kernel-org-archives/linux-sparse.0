From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: master merge plans
Date: Tue, 22 Aug 2017 15:32:00 +0200
Message-ID: <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33373 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932825AbdHVNcB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Aug 2017 09:32:01 -0400
Received: by mail-oi0-f41.google.com with SMTP id f11so185458437oic.0
        for <linux-sparse@vger.kernel.org>; Tue, 22 Aug 2017 06:32:01 -0700 (PDT)
In-Reply-To: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 21, 2017 at 9:39 PM, Christopher Li <sparse@chrisli.org> wrote:
> Here is the stuff I am considering:
>
> 3) Luc's SSSA
>     Luc has sssa-mini-v2 now. Is that the latest on to be merged?
>     I still want to have option to disable SSSA and option to enable
>     old code path. That can be done after the merge though.

I'm busy to make significant changes.
I'll resubmit everything in a few days.

> Any thing else I missed? Please let me know.

Nicolai's constexpr series.

-- Luc
