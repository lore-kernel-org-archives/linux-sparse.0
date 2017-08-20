From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: SSSA and some C pointer manipulation.
Date: Sun, 20 Aug 2017 01:33:46 +0100
Message-ID: <CACXZuxcez1YcYwY9SMW4mNpT-o3cm0C8u==QJFzfPvjehiBQ2A@mail.gmail.com>
References: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
 <CACXZuxdO+pco93WYtbh4W95c6r+f9fp_85TFhQvn-8UOQvOBWw@mail.gmail.com>
 <CANeU7Q=x_DZzp93jP9AU5zpTuggR1AGa9pYqwi-kitXV5EKs0w@mail.gmail.com>
 <CACXZuxf-yb5WODCDJ2cQxJ2_sKUwSeKwAmOX+GHCWpd0qOvGvQ@mail.gmail.com> <CAMHZB6EqBouFuAMy+Nvr=XAJqxZBGgrRSzsz=zbhv-yQ6zLJtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:38132 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbdHTAds (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 19 Aug 2017 20:33:48 -0400
Received: by mail-vk0-f53.google.com with SMTP id g189so41706403vke.5
        for <linux-sparse@vger.kernel.org>; Sat, 19 Aug 2017 17:33:47 -0700 (PDT)
In-Reply-To: <CAMHZB6EqBouFuAMy+Nvr=XAJqxZBGgrRSzsz=zbhv-yQ6zLJtg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 20 August 2017 at 01:08, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Aug 19, 2017 at 1:57 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> Yes. I have a growing set of tests but I only check the final result
>> is correct - i.e. the code can be run (both with and without
>> simplifications) and will produce expected results.
>
> While I'm all in favour of such tests, I also think that at the current
> stage of sparse's development, such tests are not what we
> need because:
> 1) to be able to run/execute the code you need a whole machinery
>     we don't have yet
> 2) they are dependent on implementation details, kinda architecture/
>     machine specific
> 3) they are dependent on the correctness of the backend used
> 4) they are dependent on run-time support (like printf()
>     implementation, for example.
> 4) they don't help at all to debug
>
> So, this kind of tests makes a lot of sense to you because you're
> developing a backend. They will certainly be useful later if/when
> sparse will have a backend. But currently, small, specific, more
> unit-like tests are much more useful to me.
>

I think you are raising a deeply philosophical issue. I firmly believe
all tests are good and needed, and take the pragmatic view that I will
use whatever tests I can lay my hands on. Sure we want unit tests as
these help debug problems. But these need to be written by whoever is
developing a feature or enhancement. Perhaps Sparse should adopt the
contribution policy that no changes should be accepted without
accompanying unit tests.

Regards
Dibyendu
