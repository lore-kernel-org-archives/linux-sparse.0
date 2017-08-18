From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Fri, 18 Aug 2017 21:21:48 +0200
Message-ID: <CAMHZB6H12RnZe3Swai56AZYfZBc8_wOabtb+2iWtuz=Kmdy_Uw@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
 <CACXZuxfQejAOR-JwSh+tYtjBgr3wYawVgEFNAXRU6c_QoTQKRA@mail.gmail.com>
 <CAExDi1SBiBWPO8RzfbxDbEnqaDTqO=EFX9HmjB+BjsaW75Ccbw@mail.gmail.com>
 <CACXZuxd4FLJ7h7jeyi_NL8eDseciidShLX7xWMmF84bOBLxmVg@mail.gmail.com>
 <CAExDi1TNbGgNkKqaPM0tgUof6m9hJVSR-XZaYbQO4QOPewFjzw@mail.gmail.com>
 <CACXZuxf0gQfdMqa6XLmcmnrzD9SzqefL5Aw9+AsuYqp8cC_HnQ@mail.gmail.com>
 <CANeU7QkGxD3g=kQkMHKNzagMA51moni0EHy_iazEDidQjEeZQg@mail.gmail.com>
 <CACXZuxd0aesRaQYqq8hzojxLQUfowZmdLT3c_8ZN2nUe6tbbzg@mail.gmail.com> <CANeU7Qk5=4Cm7HVeCk402nz4p2HivossoMgM6XTxHrk41Dz2BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33724 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdHRTVu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 15:21:50 -0400
Received: by mail-vk0-f51.google.com with SMTP id j189so35300063vka.0
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 12:21:49 -0700 (PDT)
In-Reply-To: <CANeU7Qk5=4Cm7HVeCk402nz4p2HivossoMgM6XTxHrk41Dz2BA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 18, 2017 at 8:35 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> As the way this ssa conversion is implement. I actually don't know
> how hard it is to skip the promotion.

It's very easy, you just need for is_promotable() to always return
false. But really, what would be the point?

The points that matter to me are:
1) generate correct SSA information.
    This is ultra-important because with incorrect SSA
     a lot of the optimizations are wrong, introduce errors
     and infinite loops or need ugly workarounds.
2) correct any other issues sparse could have with the generated IR
3) correct any errors sparse could have with an optimization
4) add support for construct sparse doesn't support yet
5) add more features, make the sparse's code more efficient
    and the generated IR too.
5') do not forget that sparse is firstly the/a C checker for the kernel
    (and others projects).

>> I have a question though. For my other backend I need liveness
>> analysis done even if I skip the other steps. Is it okay to run the
>> liveness analysis phase while skipping the CSE / Flow simplification
>> phases?
>
> You can, but it is less effective. You will see a lot of load/store into the
> memory. SSA make it easy to trace the define and usage chain.
> Without that you can't really see well what is going on with the content
> of the memory.

Indeed, but I'm not very sure about Dibyendu's question here.
You can have promoted all possible memory accesses to pseudos
and still generating totally un-optimized code because you skipped
the CSE and all others optimizations. It's two largely orthogonal
things.

-- Luc
