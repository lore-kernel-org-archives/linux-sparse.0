From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm issue with handling of phisrc instruction
Date: Wed, 22 Mar 2017 21:46:40 +0100
Message-ID: <CAMHZB6FNXHwBtt1jTZ8tS3jPduezrJyGeMTROB_D74FgVxRQtA@mail.gmail.com>
References: <CACXZuxdzxg_+rXu-OEUe+CwbbW+C-0CHZ=1wRrGa1ysptGDozA@mail.gmail.com>
 <CAExDi1RkSpRpSdm9i8ADSOkrQdVBMHNb=K5b+he4Gy4MMjD9wg@mail.gmail.com>
 <CACXZuxecFEoQPsUcbq8Oujvt5OYiscqcuYeMwQc5fv1ehPuAgA@mail.gmail.com>
 <CAExDi1Q_FMB+W_0-vscA6KWSPs4nZ4Dzmb42DrSrzFJ3Y5MiKw@mail.gmail.com>
 <CACXZuxfrMKckUhy9+kWGeBZt2dWiFqmXEvgJgCV7xmWej3A_Fw@mail.gmail.com>
 <20170322192929.waqifaco6wtm7wue@macpro.local> <CACXZuxeo24ABdTRgm_VR1UOvbGZ8-9rCpmDtLD8yqPNLeA1suw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35189 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbdCVUqn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 16:46:43 -0400
Received: by mail-qt0-f174.google.com with SMTP id x35so160952829qtc.2
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 13:46:42 -0700 (PDT)
In-Reply-To: <CACXZuxeo24ABdTRgm_VR1UOvbGZ8-9rCpmDtLD8yqPNLeA1suw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 22, 2017 at 8:46 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> On 22 March 2017 at 19:29, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>> >>>> I am trying to see if sparse-llvm can handle unsimplified IR output
>>> >>>> from linearizer. I think there is a problem in how it handles phisrc.
>>> >>>
>>> >>> Does your non-simplified sparse IR contain the liveness information?
>>> >>> I think those are needed for the handling of OP_PHI & OP_PHISOURCE
>>> >>> in sparse-llvm.
>>> >>>
>>> >>
>>> >> Probably not - I commented out everything in linearize_fn() from
>>> >> simplify_symbol_usage() and downwards. Please tell me if this is
>>> >> incorrect.
>>> >
>>> > As far as I understand, sparse-llvm needs track_pseudo_liveness().
>>> >
>>>
>>> Tried that - it made no difference.
>>
>> I'm not sure liveness info has much sense without simplification,
>> at least part of it.
>>
>
> You were right - I needed to retain following line:
>
> track_pseudo_death(C, ep);
>
> I mistakenly thought (going by name) that I had to call:
>
> track_pseudo_liveness(C, ep);

It's what I thought too :)

> Anyway it appears that this now populates the phi_users list so that
> the code works correctly.
>
> Thanks for your help.

Great.
You're welcome.
