From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC PATCH 00/48] fix promotion of symbol to register
Date: Sun, 27 Aug 2017 01:16:25 -0400
Message-ID: <CANeU7Q=3fuZ3FotCgs5HY7hNBX0hQD--bjXQEbRR=1hcVVQPMw@mail.gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com> <CANeU7Q=jDt-RLxa8g3HND1reGjeM-j_d=E7JxJrD=BMQFgwaQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37799 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbdH0FQ0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 27 Aug 2017 01:16:26 -0400
Received: by mail-yw0-f194.google.com with SMTP id s143so1851048ywg.4
        for <linux-sparse@vger.kernel.org>; Sat, 26 Aug 2017 22:16:26 -0700 (PDT)
In-Reply-To: <CANeU7Q=jDt-RLxa8g3HND1reGjeM-j_d=E7JxJrD=BMQFgwaQg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 27, 2017 at 12:40 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Aug 23, 2017 at 4:15 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>>   git://github.com/lucvoo/sparse.git mem2reg
>>
>
> Hi Luc, I did not see your mem2reg branch on github.
> Did you push it on github?
>
> Sorry haven't have chance to get to it earlier.

Hmm, with all the patch applied. sparse seems takes forever on
two files of the full kernel check stress test. It looks like it is
in a deadloop.

 sound/pci/hda/hda_generic.c
 drivers/block/drbd/drbd_receiver.c

Chris
