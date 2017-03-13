From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Error handling in sparse-llvm
Date: Mon, 13 Mar 2017 11:00:24 +0000
Message-ID: <CACXZuxfOgu_LbgG1iT8S2nYz5CAr181zOaM7jivsYKA4hO1vqg@mail.gmail.com>
References: <CACXZuxcU4ZQ0=D67F4EkqyFKANQVjhSxfSzsqdzXbNXYsGXGfQ@mail.gmail.com>
 <20170312195315.bdjcqd5guhvkwvfj@macpro.local> <CACXZuxeKQgPZWd-AQkzQnMMH0EyQOuinzUTXL9qkWYk3pbi6XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36363 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbdCMLA0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Mar 2017 07:00:26 -0400
Received: by mail-io0-f169.google.com with SMTP id l7so81245881ioe.3
        for <linux-sparse@vger.kernel.org>; Mon, 13 Mar 2017 04:00:25 -0700 (PDT)
In-Reply-To: <CACXZuxeKQgPZWd-AQkzQnMMH0EyQOuinzUTXL9qkWYk3pbi6XA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 13 March 2017 at 10:43, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 12 March 2017 at 19:53, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Sun, Mar 12, 2017 at 07:40:18PM +0000, Dibyendu Majumdar wrote:
>>> At present there are a bunch of asserts for scenarios not handled by
>>> Sparse LLVM backend. A more robust error handling method is needed
>>> that works even in release builds, and doesn't abort the process.
>>> Given the way the code is structured currently, I was thinking maybe
>>> it will be easiest to use setjmp/longjmp mechanism to terminate the
>>> LLVM backend on error. I am not sure that this entirely safe with LLVM
>>> as the LLVM code is C++ - I think it might be okay as long as the LLVM
>>> module / context is properly disposed at the end.
>>
>> By far, the best thing that can be done is to add support for the missing
>> features/scenarios so that those asserts can be removed.
>>
>
> Agreed, but that will probably take some time. In the meantime even
> with the subset supported by Sparse-LLVM it can be used in
> applications - provided it deals with supported features gracefully
> and generates correct code for supported features.
>

Apologies for the typo - I meant to say 'it deals with unsupported
features gracefully'.

Regards
