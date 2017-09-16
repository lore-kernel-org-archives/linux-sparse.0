From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
Date: Sat, 16 Sep 2017 09:50:07 +0200
Message-ID: <CAExDi1TpPbeYV+ryhbKh1pe88sGtnFKRd9_TNcbNJ0FgkmB=3A@mail.gmail.com>
References: <20170914200327.15129-1-uwe@kleine-koenig.org> <CANeU7QkUorcf-ADV+hKGBBkGpssL==tFtajikVDxug_Z4ffYNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:38246 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdIPHuJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 16 Sep 2017 03:50:09 -0400
Received: by mail-io0-f194.google.com with SMTP id e9so5722518iod.5
        for <linux-sparse@vger.kernel.org>; Sat, 16 Sep 2017 00:50:08 -0700 (PDT)
In-Reply-To: <CANeU7QkUorcf-ADV+hKGBBkGpssL==tFtajikVDxug_Z4ffYNg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Sep 15, 2017 at 6:56 PM, Chris Li <christ.li@gmail.com> wrote:
> On Thu, Sep 14, 2017 at 4:03 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig=
.org> wrote:
>> +    } elsif ($spec eq 'gnu/kfreebsd') {
>> +       return &add_specs ('unix') .
>> +           ' -D__FreeBSD_kernel__=3D1'
>
> This looks good. I will apply it.
> I don't have FreeBSD to test it though.

FYI, this is not really FreeBSD, it's Debian's GNU/kFreeBSD:
GNU for userland with a FreeBSD kernel.

> I assume you do
> the sufficient testing on it already.

Yes, my point of view too.

-- Luc
