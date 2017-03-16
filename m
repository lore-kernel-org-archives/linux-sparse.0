From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 16 Mar 2017 18:04:03 +0000
Message-ID: <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com> <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33671 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdCPSMD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 14:12:03 -0400
Received: by mail-it0-f66.google.com with SMTP id g138so8380956itb.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 11:11:27 -0700 (PDT)
In-Reply-To: <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

Hi Linus,

On 16 March 2017 at 17:25, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sat, Mar 11, 2017 at 7:47 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> This is a RFC for giving a type to constants/PSEUDO_VALs.
>
> Linearization has fundamentally gotten rid of all the C types, and all
> you can find are some rough remnants of them (you can find the *size*
> of the type, and you can find the rough "type" of type - is it a
> pointer, FP value or integer. There aren't even any signs, although
> some _operations_ are signed (but not the pseudos).
>

I think that having the size and information whether an integer
constant is an integer or pointer should be good enough, but as far as
I understood for pseudos of type PSEUDO_VAL even this is not
available. Only the value is available. This poses a problem
especially when passing arguments to a variadic function. In
sparse-llvm I think we need to cast values to their expected types to
keep LLVM happy. From my investigations so far this works most of the
time but the corner case appears to be passing integer/pointer
constants to variadic functions. In the normal case we can use the
function prototype to work out the required types.

Is it possible to at least retain size / and kind (int or pointer) for
pseudos representing integer constants? Perhaps the RFC could be
amended to say that?

Thanks and Regards
Dibyendu
