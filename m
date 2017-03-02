From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 05:41:59 +0000
Message-ID: <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local> <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com> <20170302052124.fsqogvysufayy4to@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33840 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753574AbdCBFmA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 00:42:00 -0500
Received: by mail-io0-f173.google.com with SMTP id 90so46563310ios.1
        for <linux-sparse@vger.kernel.org>; Wed, 01 Mar 2017 21:42:00 -0800 (PST)
In-Reply-To: <20170302052124.fsqogvysufayy4to@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 2 March 2017 at 05:21, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> Anyway have hit a bunch of other issues with sparse-llvm ... :-(
>
> Each day its problem (and happily its solution too!).
>

I will submit test cases for the new problems when I get some time.
But I am beginning to think that there is quite a bit of work needed
to fix the issues, and in any case it might be better to create an
LLVM backend from the parse tree rather than the linearized version.
The current approach is very low level - for example struct member
access bypasses the natural LLVM way of doing it. This approach will
have the consequence that LLVM will generate poor quality code as it
will not have enough information to optimise properly. The current
approach is more suited to backends that directly emit machine code I
think.

Regards
Dibyendu
