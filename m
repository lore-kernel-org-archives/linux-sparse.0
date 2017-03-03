From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Fri, 3 Mar 2017 04:38:35 +0000
Message-ID: <CACXZuxd-ZbSdwENfSaqCEtQEf8i22CXhDjA_hkyigKhL2wZTiw@mail.gmail.com>
References: <20170302052124.fsqogvysufayy4to@macbook.local>
 <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local> <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local> <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxdr9ubL6S8PEzAHtOt9AT=PjYcv_8EotLD8_Cagc7ZGPw@mail.gmail.com>
 <20170302171842.xuk535w6wrfxke3b@macpro.local> <20170302200916.4agmd5jihtkzyvp5@macpro.local>
 <CACXZuxfNkXS2qaLW+GoeOZ6TK57jJMzpRNdVCr418Bac-U7=MA@mail.gmail.com> <20170303042753.vn4kc474erpnysdm@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:37877 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdCCH0I (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 02:26:08 -0500
Received: by mail-it0-f50.google.com with SMTP id 203so8112247ith.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 23:26:07 -0800 (PST)
In-Reply-To: <20170303042753.vn4kc474erpnysdm@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 3 March 2017 at 04:27, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Mar 03, 2017 at 02:52:00AM +0000, Dibyendu Majumdar wrote:
>> I get LLVM assertion failure for following instruction:
>>
>> insn cast.64     %r4 <- (64) %r2
>>
>> Assertion failed: isa<X>(Val) && "cast<Ty>() argument of incompatible
>> type!", file C:\d\llvm-3.9.0.src\include\llvm/Support/Casting.h, line
>> 237
>>
>> I think this is because the linearize is outputting an integer cast
>> rather than pointer cast so LLVM is not happy.
>
> Yes.
> Here I have something that talk more to me:
>         ZExt only operates on integer
>           %R4 = zext %struct.link_st* %load_target to i8*
>

Also by casting to an integer subsequent operations fail. Any idea why
cast is being output rather than ptrcast?

Regards
