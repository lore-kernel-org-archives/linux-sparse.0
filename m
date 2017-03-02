From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 17:18:16 +0000
Message-ID: <CACXZuxdaYwKm2pJV3zbusUbUdKx2M-nVjSJBfV6G4QwTY1vJ-A@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local> <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local> <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local> <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local> <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxeayh3PUdypas6Ww_1mT23ZOuJiZZA_NWDkSQbfes9Xzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:35748 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753618AbdCBR0f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 12:26:35 -0500
Received: by mail-it0-f45.google.com with SMTP id 203so123172761ith.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 09:25:15 -0800 (PST)
In-Reply-To: <CACXZuxeayh3PUdypas6Ww_1mT23ZOuJiZZA_NWDkSQbfes9Xzw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

I was looking at whether I can use the standard LLVM GEP api to access
struct and array members in sparse-llvm. I noticed that the output
from sparse has byte offsets of each member - but not the member's
ordinal position. To use the native LLVM methods we would have to
allow LLVM to work out byte offsets, and just use the struct or array
definition. This would I think make the code more robust and also lead
to better optimisation.

Unfortunately LLVM does not support unions so for unions a bit of what
is being done now is probably needed, but even here it is better to
cast a union to its member struct type and then use LLVM GEP api to
access its members.

What do you think?

I think adding the ordinal position to sparse symbols is a trivial
enhancement - do you agree?

Regards
Dibyendu
