From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Fri, 3 Mar 2017 12:39:24 +0000
Message-ID: <CACXZuxf9fxwA60OBj7hvdUrrT9Mw0EAF9YaHaKygiFGNr_VwXg@mail.gmail.com>
References: <20170302052124.fsqogvysufayy4to@macbook.local>
 <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local> <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local> <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxdr9ubL6S8PEzAHtOt9AT=PjYcv_8EotLD8_Cagc7ZGPw@mail.gmail.com>
 <20170302171842.xuk535w6wrfxke3b@macpro.local> <20170302200916.4agmd5jihtkzyvp5@macpro.local>
 <CACXZuxfNkXS2qaLW+GoeOZ6TK57jJMzpRNdVCr418Bac-U7=MA@mail.gmail.com>
 <20170303042753.vn4kc474erpnysdm@macpro.local> <CACXZuxd-ZbSdwENfSaqCEtQEf8i22CXhDjA_hkyigKhL2wZTiw@mail.gmail.com>
 <CAExDi1T++WcupS6iiOkhuzuV8pgtuqAL9ftbQF00AQdABeoQFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:37503 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdCCNos (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 08:44:48 -0500
Received: by mail-it0-f50.google.com with SMTP id 203so12958168ith.0
        for <linux-sparse@vger.kernel.org>; Fri, 03 Mar 2017 05:43:50 -0800 (PST)
In-Reply-To: <CAExDi1T++WcupS6iiOkhuzuV8pgtuqAL9ftbQF00AQdABeoQFQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 3 March 2017 at 07:50, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Mar 3, 2017 at 5:38 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> Also by casting to an integer subsequent operations fail. Any idea why
>> cast is being output rather than ptrcast?
>
> Yes, it's because casts to void* is not considered as a pointer cast,
> the rationale
> being that a void* will need to be casted toa real pointer before being used.
>
> Have you still problem after the patch I sent earlier (cfr:
> https://patchwork.kernel.org/patch/9602045/ )?
>

I applied the patch but there is still the same problem as the op_cast
is converting a pointer to int, but then the following operation
expects a pointer.

Regards
