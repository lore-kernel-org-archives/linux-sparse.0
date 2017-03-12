From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC v0 0/4] Give a type to constants, considered harmful
Date: Sun, 12 Mar 2017 22:25:48 +0000
Message-ID: <CACXZuxd=G7mMX2msGh6TuQMgDYkM3G6H5O2Yab6MWbWPJmWtKA@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com> <20170312203040.erc4n2iollen2274@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36709 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935530AbdCLWZu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 18:25:50 -0400
Received: by mail-io0-f169.google.com with SMTP id l7so74540915ioe.3
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 15:25:49 -0700 (PDT)
In-Reply-To: <20170312203040.erc4n2iollen2274@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On 12 March 2017 at 20:30, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Mar 11, 2017 at 04:47:21PM +0100, Luc Van Oostenryck wrote:
>> This is a RFC for giving a type to constants/PSEUDO_VALs.
>>
>> Not having this info if fine for the linearization/simplification
>> but is quite painful once trying to generate code of it.
>>
>> This serie try to do this by:
>> - shuffling some fields in struct pseudo to allow
>>   PSEUDO_VAL to have the ::sym field too without
>>   without increasing the size of the structure.
>> - mechanically initialize each PSEUDO_VAL's ::sym
>>   with the appropriate type.
>>
>> This serie have been tested on the test suite only.
>> Thsi serie also doesn't make any use yet of this type info.
>
> I have begun to try to make use of this and I'm now convinced
> that this direction is not a viable solution for sparse.
>
> Sparse's IR is slightly lower-level that LLVM's IR, more close
> to what a real CPU would do. This can already be seen at some
> instructions (nothing like GEP in sparse), the real difference
> is less obvious but it's heer that things begin to hurt.
> Indeed, sparse's CPU-like model implies that values are typeless
> but have a size and sparse's CSE and simplification is heavily
> based on this.
> Once you try to add and maintain complete and correct typing to
> sparse's instructions so that they can be used easily by sparse-llvm
> you realize that:
> - you need to add a lot more casts
> - you need to change CSE to make things equivalent only if they
>   have the same type
> - a lot of simplifications are wrong, some can be corrected by adding
>   even more casts.
>
> So, while I'm very fine to add typing info where it was missing,
> I have no interest in making the simplifications more complex and
> of lesser quality.
>

I do not know / understand enough to comment on this but I find that
your patches are working well for sparse-llvm. In particular without
the type information in constants, I cannot see how variadic functions
can be called correctly.

If the changes done so far haven't broken anything then perhaps they
can be left in?

Regards
Dibyendu
