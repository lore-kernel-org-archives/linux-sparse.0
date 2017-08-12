From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] avoid infinite loop during simplification
Date: Sat, 12 Aug 2017 16:17:21 +0200
Message-ID: <CAExDi1RZ9v_5TFvcAOF2JkPWJYD_awt9uqga8tSvgzpmoaHrWQ@mail.gmail.com>
References: <20170812125525.34044-1-luc.vanoostenryck@gmail.com> <CANeU7QmjFd17UTFGSe_FOR+0jTn+azzaHvwq_FtG6sSGL1sx+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34073 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbdHLORW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 10:17:22 -0400
Received: by mail-oi0-f47.google.com with SMTP id x3so54603376oia.1
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 07:17:22 -0700 (PDT)
In-Reply-To: <CANeU7QmjFd17UTFGSe_FOR+0jTn+azzaHvwq_FtG6sSGL1sx+Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 12, 2017 at 3:55 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> Are you considering this in this release?

Yes, I do.
I've another version with a tunable but this one I made for a
quick inclusion in the release.

>
> I think we might also want to have the option that if max loop
> was reached,  dump the instruction and see what the hell is going
> on here. The dumping can be turn off.

That make sense for a dev point of view but the patch is
for the users. Having the dumping done by default make
no sense for them, so this can be done later.

-- Luc
