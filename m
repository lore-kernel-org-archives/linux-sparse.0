From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 20:51:06 +0100
Message-ID: <CACXZuxcJh=VGuNMEm+RtWzxG_pO-kEA-xx7E-Craf3fJFTSAYg@mail.gmail.com>
References: <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local> <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
 <20170806140035.f2tqkmiufjytiwri@ltop.local> <CANeU7QnjRSnnSc8ew69-0M7XP2zoSVh3jhCciYDRVF0i24d=sQ@mail.gmail.com>
 <20170806150712.seci4rq2nhuqx2mc@ltop.local> <CANeU7QnbtvGQMBZjfBSA-njbMMrPVcTb4xTOU8kd_JPb14n63Q@mail.gmail.com>
 <20170806165156.onm2bzojkueit6ec@ltop.local> <CANeU7QnqdkrtxbCzc8_g6BBjFzdcw4XgfB-8vmBq6esb7mq9aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37539 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbdHFTvI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 15:51:08 -0400
Received: by mail-wm0-f45.google.com with SMTP id t201so54135973wmt.0
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 12:51:07 -0700 (PDT)
In-Reply-To: <CANeU7QnqdkrtxbCzc8_g6BBjFzdcw4XgfB-8vmBq6esb7mq9aw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 6 August 2017 at 19:35, Christopher Li <sparse@chrisli.org> wrote:
> If we agree sparse shouldn't generate the following.
>
>           and.32      %r3 <- %r4, $-65
>           or.32       %r4 <- %r3, $64
>
> Let's fix it then.
>

I agree that simplifications must not result in incorrect code (in my
case correct code is more valuable than efficient code) - and in this
particular example, the C code is legal and correct and this is not an
instance of an uninitialized variable because in the C code the
variable is assigned a value prior to it being accessed.

I am not sure that this is easy to fix though - as the original IR
does not capture the intent of the C program. Maybe you could have a
separate IR instruction to assign value to a bit field - rather than
using load/and/or sequence. This will enable the original IR to
reflect the intent of the C program more accurately and hopefully
enable the simplification phase can handle it correctly.

Regards
Dibyendu
