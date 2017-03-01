From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Wed, 1 Mar 2017 10:58:00 +0000
Message-ID: <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local> <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:35914 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752115AbdCAK7v (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 1 Mar 2017 05:59:51 -0500
Received: by mail-it0-f53.google.com with SMTP id h10so94465518ith.1
        for <linux-sparse@vger.kernel.org>; Wed, 01 Mar 2017 02:58:01 -0800 (PST)
In-Reply-To: <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 28 February 2017 at 17:03, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Feb 28, 2017 at 4:09 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> There is indeed some problems regarding this, we looked a bit at this
>> some weeks ago. However I firmly believe that the information about
>> the type belong to the operations and not the values.
>

I am trying to work out how a value pseudo correct type can be
determined when the pseudo is a function call argument. Would
appreciate any pointers on this. The current implementation of
pseudo_to_value() uses the function call instruction which is
incorrect.

Thanks and Regards
Dibyendu
