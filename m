From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC PATCH 00/48] fix promotion of symbol to register
Date: Tue, 29 Aug 2017 08:37:39 -0400
Message-ID: <CANeU7QmsSLc1wt5Qc6kknk9=7ZO8EKC-Zg4YD53-uhyJXdHV_Q@mail.gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=jDt-RLxa8g3HND1reGjeM-j_d=E7JxJrD=BMQFgwaQg@mail.gmail.com> <CANeU7Q=3fuZ3FotCgs5HY7hNBX0hQD--bjXQEbRR=1hcVVQPMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34407 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdH2Mhl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 29 Aug 2017 08:37:41 -0400
Received: by mail-yw0-f173.google.com with SMTP id t188so16238993ywb.1
        for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2017 05:37:41 -0700 (PDT)
In-Reply-To: <CANeU7Q=3fuZ3FotCgs5HY7hNBX0hQD--bjXQEbRR=1hcVVQPMw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 27, 2017 at 1:16 AM, Christopher Li <sparse@chrisli.org> wrote:
> Hmm, with all the patch applied. sparse seems takes forever on
> two files of the full kernel check stress test. It looks like it is
> in a deadloop.
>
>  sound/pci/hda/hda_generic.c
>  drivers/block/drbd/drbd_receiver.c

Hi Luc, are you seeing this at all?

The full kernel check sparse is hanging on these two files.

>>>   git://github.com/lucvoo/sparse.git mem2reg
>>>

I haven't able to fetch your branch yet. The above
result is by applying patches to master.

Thanks

Chris
