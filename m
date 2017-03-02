From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 14:05:34 +0000
Message-ID: <CACXZuxdaqzhpk2O8RbM-8dCdQCRs9QvsO=2qzB3JAcyC95eJPQ@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local> <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local> <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:37372 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdCBOHE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 09:07:04 -0500
Received: by mail-it0-f41.google.com with SMTP id 203so51777126ith.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 06:05:35 -0800 (PST)
In-Reply-To: <20170302135655.s742zcslis5r56if@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 2 March 2017 at 13:56, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Mar 02, 2017 at 05:41:59AM +0000, Dibyendu Majumdar wrote:
>> But I am beginning to think that there is quite a bit of work needed
>> to fix the issues, and in any case it might be better to create an
>> LLVM backend from the parse tree rather than the linearized version.
>
> Possible, but this will certainly need some work too.
>

True, which is why I was hoping that I could at least get the current
version working. Unfortunately even the simplest programs I through at
it fail. Looks like it hasn't really been tested as there is no
defined subset of C that works.

Maybe if we keep fixing the issues one by one we will get to a point
where it works.

Regards
