From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Wed, 1 Mar 2017 14:45:03 +0000
Message-ID: <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local> <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:35438 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbdCAOpg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 1 Mar 2017 09:45:36 -0500
Received: by mail-it0-f45.google.com with SMTP id 203so99304237ith.0
        for <linux-sparse@vger.kernel.org>; Wed, 01 Mar 2017 06:45:04 -0800 (PST)
In-Reply-To: <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 1 March 2017 at 10:58, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 28 February 2017 at 17:03, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Tue, Feb 28, 2017 at 4:09 PM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>>> There is indeed some problems regarding this, we looked a bit at this
>>> some weeks ago. However I firmly believe that the information about
>>> the type belong to the operations and not the values.
>>
>
> I am trying to work out how a value pseudo correct type can be
> determined when the pseudo is a function call argument. Would
> appreciate any pointers on this. The current implementation of
> pseudo_to_value() uses the function call instruction which is
> incorrect.
>

I have implemented a solution that get the type information from the
function prototype for pseudo values when processing function
arguments, but not sure this is correct.

Anyway have hit a bunch of other issues with sparse-llvm ... :-(

Regards
Dibyendu
