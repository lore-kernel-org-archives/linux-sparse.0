From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v6 00/15] prepare for LLVM fixes
Date: Fri, 31 Mar 2017 17:26:42 +0800
Message-ID: <CANeU7Qk_XYxG9Lq-RpkvRwrhS0zv7LwFDDTKTFWnJ_QX_uzhhA@mail.gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
 <7406f777-5e8b-5ae0-55e0-26a36ddb64b5@ramsayjones.plus.com>
 <20170327222212.jle5tzjevfsigvuw@macpro.local> <CA+55aFx+-mvbjN_m0A3ZFFVtBHEAwbmuruMS5P_082_Fr2auzg@mail.gmail.com>
 <CANeU7Q=d22MqFigDcaW1o59BTYV2rKNhfjjDCVpxA_JTDey_ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33557 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932648AbdCaJ0o (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 05:26:44 -0400
Received: by mail-io0-f176.google.com with SMTP id f84so35891698ioj.0
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 02:26:43 -0700 (PDT)
In-Reply-To: <CANeU7Q=d22MqFigDcaW1o59BTYV2rKNhfjjDCVpxA_JTDey_ag@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Mar 31, 2017 at 12:49 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> That being said, I do wish there is a way to figure out which patches
> haven't changed in the new series. e.g. from V4 to V5, only a few patches
> actually change. I can just focus on those changed one. I suppose I can
> write a script to detect the same patch on different series.
>

BTW, I just add that feature to my patch series script. It has been working
for me on the new llvm-fix series. For every patch in the new series, the
script do "interdiff" with every patch on previous series and output
the smallest
diff. That usually nicely show the incremental change compare to
previous series.

For the case there is no change, just apply that patch because it is the same
as the previous series, which I already apply and reviewed.

This feature actually work out better than I expected.

Even if I use git merge, I still need to find out exactly what change between
two branch, which has rebased and different commit mixed. e.g. V4 and V6.

Chris
