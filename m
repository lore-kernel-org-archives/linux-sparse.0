From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
Date: Sat, 8 Feb 2020 16:58:51 -0800
Message-ID: <CAHk-=whqDZUo6yARXMgwHSJRerXM4tWgMPV=MC9wR80YCEon1A@mail.gmail.com>
References: <20200207081810.3918919-1-kafai@fb.com> <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
 <CAHk-=wjbhawNieeiEig4LnPVRTRPgY8xag7NuAKuM9NKXCTLeQ@mail.gmail.com>
 <20200207204144.hh4n4o643oqpcwed@ltop.local> <CAHk-=whvS9x5NKtOqcUgJeTY7dfdAHcEALJT53cy3P7Hzfgr1g@mail.gmail.com>
 <20200208235459.xmliqf2ksbre53jj@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46254 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgBIA7L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Feb 2020 19:59:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id x14so3161911ljd.13
        for <linux-sparse@vger.kernel.org>; Sat, 08 Feb 2020 16:59:09 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id g27sm3176775lfh.57.2020.02.08.16.59.07
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 16:59:07 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id t23so1752595lfk.6
        for <linux-sparse@vger.kernel.org>; Sat, 08 Feb 2020 16:59:07 -0800 (PST)
In-Reply-To: <20200208235459.xmliqf2ksbre53jj@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Feb 8, 2020 at 3:55 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> > Something like the attached completely broken patch. It builds but
> > doesn't work, because "inline_function()" is currently designed to
> > work during evaluation, not during expansion.
> >
> > So the patch is complete garbage, but maybe could be the starting
> > point for something that works.
>
> It was just missing the part with current_fn (needed for the evaluation)
> and some adjustment to avoid recursive expansions.

Oh, good. I looked at that current_fn thing and decided it shouldn't
possibly matter, so my hacked-up patch just dropped it. Blush. And
yeah, the recursion avoidance got broken because it only triggered
during evaluation and that wasn't where it was recursing any more.

Anyway, your fixed patch looks good, and the numbers look lovely. I
don't see why there would sometimes be extra memory use, but the patch
feels like the right thing to do regardless.

Thanks,
               Linus
