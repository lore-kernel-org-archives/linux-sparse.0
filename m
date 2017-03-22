From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm issue with handling of phisrc instruction
Date: Wed, 22 Mar 2017 20:48:03 +0000
Message-ID: <CACXZuxdTXz801Dy6QhQJ7gwKfi3B4MPWRAjmz579Qzs1JXA+Jg@mail.gmail.com>
References: <CACXZuxdzxg_+rXu-OEUe+CwbbW+C-0CHZ=1wRrGa1ysptGDozA@mail.gmail.com>
 <CAExDi1RkSpRpSdm9i8ADSOkrQdVBMHNb=K5b+he4Gy4MMjD9wg@mail.gmail.com>
 <CACXZuxecFEoQPsUcbq8Oujvt5OYiscqcuYeMwQc5fv1ehPuAgA@mail.gmail.com>
 <CAExDi1Q_FMB+W_0-vscA6KWSPs4nZ4Dzmb42DrSrzFJ3Y5MiKw@mail.gmail.com>
 <CACXZuxfrMKckUhy9+kWGeBZt2dWiFqmXEvgJgCV7xmWej3A_Fw@mail.gmail.com>
 <CACXZuxfaQn+XApJpRY_63zf28VSeywj6R_kmy1sUHU3kEFpu-g@mail.gmail.com> <20170322204258.gpyewnksfccv5bta@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34610 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbdCVUsE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 16:48:04 -0400
Received: by mail-io0-f172.google.com with SMTP id b140so71808905iof.1
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 13:48:04 -0700 (PDT)
In-Reply-To: <20170322204258.gpyewnksfccv5bta@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 22 March 2017 at 20:42, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, Mar 22, 2017 at 06:55:37PM +0000, Dibyendu Majumdar wrote:
>> If there is a single phisrc and phi instruction then is phisrc meant
>> to have the phi in its user list?
>
> Yes but again this may depends on the simplification for
> its correctness.
>
> Also, for phi-nodes liveness is a bit different, unintuitive at first,
> the PSEUDO_PHI play no role in liveness. So, in IR code like:
>    .L0
>         phisrc  %phi1 <- ...
>         ...
>
>    .L1
>         phi     %r2 <- %phi1, %phi2
>
> the "liveness between .L0 & .L1" is not made via %phi1 but with the
> "real" pseudo: %r2 (.L0 defines %r2, .L1 needs %r2).
>

Luckily (or by design) the track_pseudo_death() is called right at the
end after all the modifications are done. So I think it will always be
correct as long as this is called.

Regards
Dibyendu
