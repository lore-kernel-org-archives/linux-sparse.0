From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: multiarch & base dir
Date: Sun, 5 Nov 2017 11:08:54 +0100
Message-ID: <CAExDi1TBXTky_A9LWCODzHBg8JjWq29m9rGr59h+KsA9XQegXg@mail.gmail.com>
References: <20171105093301.adsucwshznehtdr4@ltop.local> <CANeU7QkaiPxUcw7g+jGdNY1JZd8=MuMa=k11kX7PKmBMzPaQGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:54517 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdKEKI4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 05:08:56 -0500
Received: by mail-io0-f176.google.com with SMTP id e89so12766590ioi.11
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 02:08:55 -0800 (PST)
In-Reply-To: <CANeU7QkaiPxUcw7g+jGdNY1JZd8=MuMa=k11kX7PKmBMzPaQGg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 5, 2017 at 10:59 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Nov 5, 2017 at 5:33 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> Commit 85e2e2a25 "Add support for multiarch system header files"
>> added for GCC's multiarch directory. One of the change was :
>> +       /* add the multiarch include directories, if any */
>> +       if (multiarch_dir && *multiarch_dir) {
>> +               add_pre_buffer("#add_system \"/usr/include/%s\"\n", multiarch_dir);
>> +               add_pre_buffer("#add_system \"/usr/local/include/%s\"\n", multiarch_dir);
>> +       }
>>
>>
>> There, the multiarch dir is appended to /usr/include & /usr/local/include.
>> I'm wondering if using GCC_BASE should be used here instead.
>> Any thoughts?
>
> I think the multiarch is for cross compile.

Not really. It's mainly used to support both 32 & 64-bit binaries on the same
platform (which supports it).

-- Luc
