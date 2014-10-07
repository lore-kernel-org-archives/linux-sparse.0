From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 07/10] Add support for multiarch system header files
Date: Tue, 7 Oct 2014 11:55:57 +0800
Message-ID: <CANeU7QmBc6Ogh-U-rfxfrvM+j8BS_HzTs6CaAQ7eGY4F+qDrZg@mail.gmail.com>
References: <53DFD350.6080701@ramsay1.demon.co.uk>
	<CANeU7QnuZucjgq2b972ZxBi0e1TZpz=mMjo6SCRvk5mngXaETg@mail.gmail.com>
	<54326F8B.1050201@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:52754 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbaJGDz7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 6 Oct 2014 23:55:59 -0400
Received: by mail-wi0-f177.google.com with SMTP id fb4so6566231wid.10
        for <linux-sparse@vger.kernel.org>; Mon, 06 Oct 2014 20:55:57 -0700 (PDT)
In-Reply-To: <54326F8B.1050201@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Oct 6, 2014 at 6:31 PM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
> On 06/10/14 00:33, Christopher Li wrote:
>> My gcc(4.8, FC20) does not support "-print-multiarch".
>
> Yep, same is true for cygwin.

I see, I thought your patch is expecting some thing from gcc.
Then how to you test this code path?

>>
>>> +       if (multiarch_dir && *multiarch_dir) {
>>> +               add_pre_buffer("#add_system \"/usr/include/%s\"\n", multiarch_dir);
>>> +               add_pre_buffer("#add_system \"/usr/local/include/%s\"\n", multiarch_dir);
>>> +       }
>>
> Again, it works for me. :-D

So I guess multiarch_dir can be empty here. I just did not expect
that.

Is it always prefix with "/usr/include/" and "/usr/local/include" for
different distributions?

Chris
