From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 22:08:57 +0200
Message-ID: <CAMHZB6EELx6HLa-2qJ1x5cF8dyHjTBd0QO9trMq23Q=mPNG7XA@mail.gmail.com>
References: <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local> <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
 <20170806140035.f2tqkmiufjytiwri@ltop.local> <CANeU7QnjRSnnSc8ew69-0M7XP2zoSVh3jhCciYDRVF0i24d=sQ@mail.gmail.com>
 <20170806150712.seci4rq2nhuqx2mc@ltop.local> <CANeU7QnbtvGQMBZjfBSA-njbMMrPVcTb4xTOU8kd_JPb14n63Q@mail.gmail.com>
 <20170806165156.onm2bzojkueit6ec@ltop.local> <CANeU7QnqdkrtxbCzc8_g6BBjFzdcw4XgfB-8vmBq6esb7mq9aw@mail.gmail.com>
 <CACXZuxcJh=VGuNMEm+RtWzxG_pO-kEA-xx7E-Craf3fJFTSAYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35848 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdHFUI7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 16:08:59 -0400
Received: by mail-qk0-f177.google.com with SMTP id d136so31070262qkg.3
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 13:08:58 -0700 (PDT)
In-Reply-To: <CACXZuxcJh=VGuNMEm+RtWzxG_pO-kEA-xx7E-Craf3fJFTSAYg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 9:51 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Chris,
>
> I agree that simplifications must not result in incorrect code (in my
> case correct code is more valuable than efficient code) - and in this
> particular example, the C code is legal and correct and this is not an
> instance of an uninitialized variable because in the C code the
> variable is assigned a value prior to it being accessed.

Just for the sake of completeness, it's not exactly simplification
that produce incorrect code. Like often, it's the interaction of
several things, here related to uninitialized vars (s3 is not
initialized, it shouldn't matter but it currently does).

> I am not sure that this is easy to fix though - as the original IR
> does not capture the intent of the C program.

It shouldn't be too hard.

> Maybe you could have a
> separate IR instruction to assign value to a bit field - rather than
> using load/and/or sequence. This will enable the original IR to
> reflect the intent of the C program more accurately and hopefully
> enable the simplification phase can handle it correctly.

Yes. I already thought about it several times but I never was able
to convince myself that it would be worth.
For dealing correctly with the case here we need *more*, *smarter*
simplifications. With specific instructions, it would be a bit easier
(but probably only a little bit) and will want these kind of simplifications
anyway so the new instructions will only add more code, need to deal
with similar situation in two different places, ...
This is related to the fact that sparse IR is quite low-level, as we already
talked about.

Maybe it would be good to first linearize to less low-level IR and then
lower the IR. I think something like this will be needed soon or later.

-- Luc
