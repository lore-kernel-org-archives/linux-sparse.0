From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
Date: Fri, 7 Feb 2020 10:07:32 -0800
Message-ID: <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
References: <20200207081810.3918919-1-kafai@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41213 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgBGSHw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 13:07:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so242665ljc.8
        for <linux-sparse@vger.kernel.org>; Fri, 07 Feb 2020 10:07:51 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id s22sm1691645ljm.41.2020.02.07.10.07.48
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 10:07:49 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id o15so255256ljg.6
        for <linux-sparse@vger.kernel.org>; Fri, 07 Feb 2020 10:07:48 -0800 (PST)
In-Reply-To: <20200207081810.3918919-1-kafai@fb.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Martin KaFai Lau <kafai@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, David Miller <davem@davemloft.net>, kernel-team@fb.com, Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Netdev <netdev@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>

On Fri, Feb 7, 2020 at 12:18 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> It was reported that the max_t, ilog2, and roundup_pow_of_two macros have
> exponential effects on the number of states in the sparse checker.

Patch looks good, but I'd like to point out that it's not just sparse.

You can see it with a simple

    make net/core/bpf_sk_storage.i
    grep 'smap->bucket_log = ' net/core/bpf_sk_storage.i | wc

and see the end result:

      1  365071 2686974

That's one line (the assignment line) that is 2,686,974 characters in length.

Now, sparse does happen to react particularly badly to that (I didn't
look to why, but I suspect it's just that evaluating all the types
that don't actually ever end up getting used ends up being much more
expensive than it should be), but I bet it's not good for gcc either.

I do think this is a good test-case for sparse. Luc, have you looked
at what it is that then makes sparse use *so* much memory for this one
line?

             Linus
