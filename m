From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm issue with handling of phisrc instruction
Date: Wed, 22 Mar 2017 18:55:37 +0000
Message-ID: <CACXZuxfaQn+XApJpRY_63zf28VSeywj6R_kmy1sUHU3kEFpu-g@mail.gmail.com>
References: <CACXZuxdzxg_+rXu-OEUe+CwbbW+C-0CHZ=1wRrGa1ysptGDozA@mail.gmail.com>
 <CAExDi1RkSpRpSdm9i8ADSOkrQdVBMHNb=K5b+he4Gy4MMjD9wg@mail.gmail.com>
 <CACXZuxecFEoQPsUcbq8Oujvt5OYiscqcuYeMwQc5fv1ehPuAgA@mail.gmail.com>
 <CAExDi1Q_FMB+W_0-vscA6KWSPs4nZ4Dzmb42DrSrzFJ3Y5MiKw@mail.gmail.com> <CACXZuxfrMKckUhy9+kWGeBZt2dWiFqmXEvgJgCV7xmWej3A_Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:38696 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965787AbdCVSzj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 14:55:39 -0400
Received: by mail-it0-f46.google.com with SMTP id y18so28971380itc.1
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 11:55:38 -0700 (PDT)
In-Reply-To: <CACXZuxfrMKckUhy9+kWGeBZt2dWiFqmXEvgJgCV7xmWej3A_Fw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 22 March 2017 at 18:17, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>>>>> I am trying to see if sparse-llvm can handle unsimplified IR output
>>>>> from linearizer. I think there is a problem in how it handles phisrc.
>>>>
>>>> Does your non-simplified sparse IR contain the liveness information?
>>>> I think those are needed for the handling of OP_PHI & OP_PHISOURCE
>>>> in sparse-llvm.
>>>>
>>>
>>> Probably not - I commented out everything in linearize_fn() from
>>> simplify_symbol_usage() and downwards. Please tell me if this is
>>> incorrect.
>>
>> As far as I understand, sparse-llvm needs track_pseudo_liveness().
>>
>
> Tried that - it made no difference.
>

If there is a single phisrc and phi instruction then is phisrc meant
to have the phi in its user list?

I am trying out a different way of handling phisrc - I will let you
know if it works.

Regards
Dibyendu
