From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 07/10] Add support for multiarch system header files
Date: Tue, 07 Oct 2014 11:20:49 +0100
Message-ID: <5433BE81.3080604@ramsay1.demon.co.uk>
References: <53DFD350.6080701@ramsay1.demon.co.uk>	<CANeU7QnuZucjgq2b972ZxBi0e1TZpz=mMjo6SCRvk5mngXaETg@mail.gmail.com>	<54326F8B.1050201@ramsay1.demon.co.uk> <CANeU7QmBc6Ogh-U-rfxfrvM+j8BS_HzTs6CaAQ7eGY4F+qDrZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:59272 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753242AbaJGKUx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 7 Oct 2014 06:20:53 -0400
In-Reply-To: <CANeU7QmBc6Ogh-U-rfxfrvM+j8BS_HzTs6CaAQ7eGY4F+qDrZg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 07/10/14 04:55, Christopher Li wrote:
> On Mon, Oct 6, 2014 at 6:31 PM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>> On 06/10/14 00:33, Christopher Li wrote:
>>> My gcc(4.8, FC20) does not support "-print-multiarch".
>>
>> Yep, same is true for cygwin.
> 
> I see, I thought your patch is expecting some thing from gcc.
> Then how to you test this code path?

Well, I slightly mis-spoke. Of the two cygwin installations I have,
one has a version of gcc which supports '-print-multiarch' and one
doesn't (i.e. it isn't really the version of cygwin, but gcc that
seems to matter). In any case, cygwin is not a "multiarch" system,
so on my 64-bit cygwin installation 'gcc -print-multiarch' prints
a blank line (ie an empty string) and exits with 0 status. On my
old 32-bit cygwin installation (if memory serves me correctly)
then gcc prints an error message and exits with non-zero status.

This patch is old enough that it was originally tested on my old
cygwin installation (this patch was developed on my old laptop), so
I haven't tested there for some time. However, before sending this
series I distinctly remember simulating this on 64-bit cygwin by
editing the Makefile and changing the '-print-multiarch' option
to '-print-junk', which _should_ have the same effect.

[ie the $(MULTIARCH_TRIPLET) make variable should be set to the
empty string on your FC20 system.]

> 
>>>
>>>> +       if (multiarch_dir && *multiarch_dir) {
>>>> +               add_pre_buffer("#add_system \"/usr/include/%s\"\n", multiarch_dir);
>>>> +               add_pre_buffer("#add_system \"/usr/local/include/%s\"\n", multiarch_dir);
>>>> +       }
>>>
>> Again, it works for me. :-D
> 
> So I guess multiarch_dir can be empty here. I just did not expect
> that.

Yes, indeed this _must_ be empty on non-multiarch systems.

[This was developed on Ubuntu, which is a multiarch system (and
I'm now on Linux Mint 17, which is also). Until now, I didn't
know that Fedora was not! :-D ]

> 
> Is it always prefix with "/usr/include/" and "/usr/local/include" for
> different distributions?

I can't quite remember how I came up with this list (it was a while
ago), but I think I had a look at the gcc source code. (Hmm, don't
quote me on that! ;-) ).

ATB,
Ramsay Jones



