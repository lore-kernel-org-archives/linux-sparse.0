From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Fri, 3 Mar 2017 08:50:44 +0100
Message-ID: <CAExDi1T++WcupS6iiOkhuzuV8pgtuqAL9ftbQF00AQdABeoQFQ@mail.gmail.com>
References: <20170302052124.fsqogvysufayy4to@macbook.local>
 <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local> <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local> <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxdr9ubL6S8PEzAHtOt9AT=PjYcv_8EotLD8_Cagc7ZGPw@mail.gmail.com>
 <20170302171842.xuk535w6wrfxke3b@macpro.local> <20170302200916.4agmd5jihtkzyvp5@macpro.local>
 <CACXZuxfNkXS2qaLW+GoeOZ6TK57jJMzpRNdVCr418Bac-U7=MA@mail.gmail.com>
 <20170303042753.vn4kc474erpnysdm@macpro.local> <CACXZuxd-ZbSdwENfSaqCEtQEf8i22CXhDjA_hkyigKhL2wZTiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36480 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdCCHvT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 02:51:19 -0500
Received: by mail-qk0-f177.google.com with SMTP id 1so44225364qkl.3
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 23:50:46 -0800 (PST)
In-Reply-To: <CACXZuxd-ZbSdwENfSaqCEtQEf8i22CXhDjA_hkyigKhL2wZTiw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Mar 3, 2017 at 5:38 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Also by casting to an integer subsequent operations fail. Any idea why
> cast is being output rather than ptrcast?

Yes, it's because casts to void* is not considered as a pointer cast,
the rationale
being that a void* will need to be casted toa real pointer before being used.

Have you still problem after the patch I sent earlier (cfr:
https://patchwork.kernel.org/patch/9602045/ )?

Luc
