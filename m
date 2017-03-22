From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm issue with handling of phisrc instruction
Date: Wed, 22 Mar 2017 19:15:14 +0100
Message-ID: <CAExDi1Q_FMB+W_0-vscA6KWSPs4nZ4Dzmb42DrSrzFJ3Y5MiKw@mail.gmail.com>
References: <CACXZuxdzxg_+rXu-OEUe+CwbbW+C-0CHZ=1wRrGa1ysptGDozA@mail.gmail.com>
 <CAExDi1RkSpRpSdm9i8ADSOkrQdVBMHNb=K5b+he4Gy4MMjD9wg@mail.gmail.com> <CACXZuxecFEoQPsUcbq8Oujvt5OYiscqcuYeMwQc5fv1ehPuAgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33765 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965106AbdCVSPQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 14:15:16 -0400
Received: by mail-qt0-f181.google.com with SMTP id i34so158755715qtc.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 11:15:15 -0700 (PDT)
In-Reply-To: <CACXZuxecFEoQPsUcbq8Oujvt5OYiscqcuYeMwQc5fv1ehPuAgA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 22, 2017 at 7:05 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> On 22 March 2017 at 17:38, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Wed, Mar 22, 2017 at 5:46 PM, Dibyendu Majumdar
>> <mobile@majumdar.org.uk> wrote:
>>> I am trying to see if sparse-llvm can handle unsimplified IR output
>>> from linearizer. I think there is a problem in how it handles phisrc.
>>
>> Does your non-simplified sparse IR contain the liveness information?
>> I think those are needed for the handling of OP_PHI & OP_PHISOURCE
>> in sparse-llvm.
>>
>
> Probably not - I commented out everything in linearize_fn() from
> simplify_symbol_usage() and downwards. Please tell me if this is
> incorrect.

As far as I understand, sparse-llvm needs track_pseudo_liveness().

-- Luc
