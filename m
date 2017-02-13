From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 0/8] fix uses of killed instructions
Date: Mon, 13 Feb 2017 17:59:15 +0100
Message-ID: <CAExDi1QuA=Pimkv8yS4T1WVNqavuHtTn322xgeZMFe92+4pCBQ@mail.gmail.com>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
 <CAExDi1RJ8rPE7n7eGmBRnSe3FudW28HF7DkVErmVmniZrwSQJQ@mail.gmail.com>
 <20170208165055.ibu47j2axwi2j53f@macpro.local> <CANeU7Qkc1qShbgresJbRZbORuzzcMR28vPvv38kwFxHiE15ZLQ@mail.gmail.com>
 <20170208213544.ahkbsgvikwdb7nsu@macpro.local> <CANeU7Qn9CqWmQ-VUY928xm2fogqMGpfEbaBw+LrtfDbOrLTNfQ@mail.gmail.com>
 <20170208222805.c77ilwchxpg2vnx4@macpro.local> <CAExDi1RcL5J_hKxS_7R2s+fNq_YCLab6PaWr2QHMbx6sygij8w@mail.gmail.com>
 <CANeU7Q=SO7pRy4OY+K8+tkrvg_nb5+Rs0zbE4iVVpMVrFZ3yQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36146 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbdBMQ7Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Feb 2017 11:59:16 -0500
Received: by mail-qt0-f170.google.com with SMTP id k15so88813391qtg.3
        for <linux-sparse@vger.kernel.org>; Mon, 13 Feb 2017 08:59:16 -0800 (PST)
In-Reply-To: <CANeU7Q=SO7pRy4OY+K8+tkrvg_nb5+Rs0zbE4iVVpMVrFZ3yQg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Feb 13, 2017 at 12:38 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Feb 13, 2017 at 7:25 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> Sigh. I was a bit short on time when checking this and the diff I looked
>> at was somehow misleading but in fact the functionality is not at all equivalent
>> although all the tests did the expected result.
>>
>> I'm resending a respin of the two concerned series.
>
> Not problem. I will re-apply your new series.

Thanks. It's really OK now, it passes all the tests *and* is able to
detect errors now.

Luc
