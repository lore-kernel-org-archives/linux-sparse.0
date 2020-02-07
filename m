From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
Date: Fri, 7 Feb 2020 13:09:32 -0800
Message-ID: <CAHk-=wgdCXgQyBSSx-ovfiZ7WFR6fStOZ_2R9mxkX3a+R5MkxQ@mail.gmail.com>
References: <20200207081810.3918919-1-kafai@fb.com> <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
 <20200207201301.wpq4abick4j3rucl@ast-mbp.dhcp.thefacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41124 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgBGVJx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 16:09:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so267885lfp.8
        for <linux-sparse@vger.kernel.org>; Fri, 07 Feb 2020 13:09:51 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id z13sm1858216ljh.21.2020.02.07.13.09.48
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 13:09:49 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id a13so750814ljm.10
        for <linux-sparse@vger.kernel.org>; Fri, 07 Feb 2020 13:09:48 -0800 (PST)
In-Reply-To: <20200207201301.wpq4abick4j3rucl@ast-mbp.dhcp.thefacebook.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, David Miller <davem@davemloft.net>, kernel-team@fb.com, Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Netdev <netdev@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>

On Fri, Feb 7, 2020 at 12:13 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> In addition to this patch I've tried:
> +#define __const_ilog2(n, unique_n) ({                  \
> +       typeof(n) unique_n = (n);                       \

Yeah, as you found out, this doesn't work for the case of having
global initializers or things like array sizes.

Which people do do - often nor directly, but through various size macros.

It's annoying, but one of the failures of C is having a nice form of
compile-time constant handling where you can do slightly smarter
arithmetic. The definition of a "const expression" is very very
limited, and hurts us exactly for the array declaration and constant
initializer case.

Oh well.

          Linus
