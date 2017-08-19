From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: SSSA and some C pointer manipulation.
Date: Sat, 19 Aug 2017 12:57:43 +0100
Message-ID: <CACXZuxf-yb5WODCDJ2cQxJ2_sKUwSeKwAmOX+GHCWpd0qOvGvQ@mail.gmail.com>
References: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
 <CACXZuxdO+pco93WYtbh4W95c6r+f9fp_85TFhQvn-8UOQvOBWw@mail.gmail.com> <CANeU7Q=x_DZzp93jP9AU5zpTuggR1AGa9pYqwi-kitXV5EKs0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36716 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdHSL5p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 19 Aug 2017 07:57:45 -0400
Received: by mail-vk0-f47.google.com with SMTP id u133so39254404vke.3
        for <linux-sparse@vger.kernel.org>; Sat, 19 Aug 2017 04:57:44 -0700 (PDT)
In-Reply-To: <CANeU7Q=x_DZzp93jP9AU5zpTuggR1AGa9pYqwi-kitXV5EKs0w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 19 August 2017 at 11:56, Christopher Li <sparse@chrisli.org> wrote:
> On 8/19/17, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> I think it is an excellent idea to create a bunch of careful tests to
>> assess / validate the changes. Perhaps the tests should cover various
>> scenarios including switch statements, gotos, computed gotos, looping
>> constructs, etc. And specific uses of globals, pointers, locals etc.
>>
>
> That is the idea for the test suite. To test how sparse handle
> different source code.
>

Yes. I have a growing set of tests but I only check the final result
is correct - i.e. the code can be run (both with and without
simplifications) and will produce expected results. I do not check
whether the Sparse IR is optimum or not, as I have been more focussed
on getting the right outcome.

> There is also the idea of the debug version of sparse. Instead
> having the fix input source. It will do dynamic verification
> of sparse at run time. e.g. If there is a slow and reliable way
> to generate SSA conversion. Then in the debug version will do
> both the slow and reliable way and the new fast and optimal way.
> Then compare notes to draw conclusion that the new way *is* better.
> AT least not worse than the old way. In this case I want to verify
> that, the new method at least cover all the variable converted
> by the old method. Including variable used by pointers.
>

Sure but this is kind of hard to do - because to validate something
you need a definition of what is "good" or "expected". Ideally of
course the output will be correct and at least as optimum as before -
but I would rather it is correct first.

Regards
Dibyendu
