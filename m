From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: c2xml uses out of type modifiers mapping
Date: Wed, 14 Jun 2017 21:51:03 +0100
Message-ID: <CACXZuxdt53Q-0pBy8_EaKj=UGvNJ770ZBQ3NGSXz6aD0MUxeKg@mail.gmail.com>
References: <CACXZuxeVo=5Lz2idvtbeHjLJHLZ4gPissRVfCyDAsKw1mKPRTw@mail.gmail.com>
 <CANeU7Qm2nkZCDtUf1Vb2EdMCuYstc6j4Wd6tqAWyKwDH9-E-RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33691 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbdFNUvF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Jun 2017 16:51:05 -0400
Received: by mail-wr0-f182.google.com with SMTP id r103so14826201wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 14 Jun 2017 13:51:04 -0700 (PDT)
In-Reply-To: <CANeU7Qm2nkZCDtUf1Vb2EdMCuYstc6j4Wd6tqAWyKwDH9-E-RA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 13 June 2017 at 23:16, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Jun 13, 2017 at 3:02 PM, Dibyendu Majumdar
>> I noticed that the mapping for type modifiers in c2xml is out of sync
>> with the MOD_* definitions in symbol.h.
>
> Do you mean in function examine_modifiers(), the modifiers[] array
> are out of sync? It does look like so.

Yes, that is what I meant.

>
> Patch is welcome :-)
>

Happy to, although cannot promise when, as it means I will have to
setup a sparse repository for the sole purpose of creating patches.
BTW, Is there a guide on how to submit patches?

Thanks and Regards
Dibyendu
