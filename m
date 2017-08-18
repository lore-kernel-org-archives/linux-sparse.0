From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Fri, 18 Aug 2017 22:27:54 +0200
Message-ID: <CAExDi1T5RT9gsgGR2mHGCgaBUySH2jupKxyHJb2E7W6vWBaAQw@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
 <CACXZuxfQejAOR-JwSh+tYtjBgr3wYawVgEFNAXRU6c_QoTQKRA@mail.gmail.com>
 <CAExDi1SBiBWPO8RzfbxDbEnqaDTqO=EFX9HmjB+BjsaW75Ccbw@mail.gmail.com>
 <CACXZuxd4FLJ7h7jeyi_NL8eDseciidShLX7xWMmF84bOBLxmVg@mail.gmail.com>
 <CAExDi1TNbGgNkKqaPM0tgUof6m9hJVSR-XZaYbQO4QOPewFjzw@mail.gmail.com>
 <CACXZuxf0gQfdMqa6XLmcmnrzD9SzqefL5Aw9+AsuYqp8cC_HnQ@mail.gmail.com>
 <CANeU7QkGxD3g=kQkMHKNzagMA51moni0EHy_iazEDidQjEeZQg@mail.gmail.com>
 <CACXZuxd0aesRaQYqq8hzojxLQUfowZmdLT3c_8ZN2nUe6tbbzg@mail.gmail.com>
 <CANeU7Qk5=4Cm7HVeCk402nz4p2HivossoMgM6XTxHrk41Dz2BA@mail.gmail.com>
 <CAMHZB6H12RnZe3Swai56AZYfZBc8_wOabtb+2iWtuz=Kmdy_Uw@mail.gmail.com> <CANeU7Q=wgPStjUYkYCbiy5DEiLPZ-kML+2XiAwumn__FMYePTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34650 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbdHRU14 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 16:27:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id v11so10350502oif.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 13:27:55 -0700 (PDT)
In-Reply-To: <CANeU7Q=wgPStjUYkYCbiy5DEiLPZ-kML+2XiAwumn__FMYePTg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 18, 2017 at 10:14 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Aug 18, 2017 at 3:21 PM, Luc Van Oostenryck wrote:
>
>> The points that matter to me are:
>> 1) generate correct SSA information.
>>     This is ultra-important because with incorrect SSA
>>      a lot of the optimizations are wrong, introduce errors
>>      and infinite loops or need ugly workarounds.
>
> That I totally agree. Incorrect SSA can't not use as SSA at all.
>
>> 2) correct any other issues sparse could have with the generated IR
>> 3) correct any errors sparse could have with an optimization
>> 4) add support for construct sparse doesn't support yet
>> 5) add more features, make the sparse's code more efficient
>>     and the generated IR too.
>
> All agree.
>
>> 5') do not forget that sparse is firstly the/a C checker for the kernel
>>     (and others projects).
>
> Sure. But sparse need to get good IR to perform the checking.

Hence, points 2 & 3 :)

-- Luc
