From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 00/48] fix promotion of symbol to register
Date: Sun, 3 Sep 2017 21:24:11 +0200
Message-ID: <CAExDi1SWn9-yKZj1Uzp6pPZbAC19rzo4ydeeVRFwimXgN0rSeg@mail.gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=jDt-RLxa8g3HND1reGjeM-j_d=E7JxJrD=BMQFgwaQg@mail.gmail.com>
 <CANeU7Q=3fuZ3FotCgs5HY7hNBX0hQD--bjXQEbRR=1hcVVQPMw@mail.gmail.com> <CANeU7QmsSLc1wt5Qc6kknk9=7ZO8EKC-Zg4YD53-uhyJXdHV_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36139 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdICTYN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 3 Sep 2017 15:24:13 -0400
Received: by mail-lf0-f65.google.com with SMTP id l140so2530201lfg.3
        for <linux-sparse@vger.kernel.org>; Sun, 03 Sep 2017 12:24:13 -0700 (PDT)
In-Reply-To: <CANeU7QmsSLc1wt5Qc6kknk9=7ZO8EKC-Zg4YD53-uhyJXdHV_Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 29, 2017 at 2:37 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Aug 27, 2017 at 1:16 AM, Christopher Li <sparse@chrisli.org> wrote:
>> Hmm, with all the patch applied. sparse seems takes forever on
>> two files of the full kernel check stress test. It looks like it is
>> in a deadloop.
>>
>>  sound/pci/hda/hda_generic.c
>>  drivers/block/drbd/drbd_receiver.c
>
> Hi Luc, are you seeing this at all?
>
> The full kernel check sparse is hanging on these two files.

Yes, I know.
It's not a big problem in itself (was quickly solved) but ...

>>>>   git://github.com/lucvoo/sparse.git mem2reg
>>>>
>
> I haven't able to fetch your branch yet. The above
> result is by applying patches to master.

Yes, I removed it once I had some doubts about the whole series.
I hadn't the opportunity to send an email asking to ignore the series,
sorry about that.

-- Luc
