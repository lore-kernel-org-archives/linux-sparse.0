From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/6] testsuite speedup
Date: Mon, 29 May 2017 00:39:43 +0200
Message-ID: <CAExDi1S9oFHbUtv08rwGKOvjOVijzsrGm20dzW65N2ue=pUy1Q@mail.gmail.com>
References: <20170528192906.1023-1-luc.vanoostenryck@gmail.com> <47420cd6-74bc-8037-5d92-7e65f8aa8560@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33425 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdE1Wjo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 May 2017 18:39:44 -0400
Received: by mail-qk0-f174.google.com with SMTP id y201so37534978qka.0
        for <linux-sparse@vger.kernel.org>; Sun, 28 May 2017 15:39:44 -0700 (PDT)
In-Reply-To: <47420cd6-74bc-8037-5d92-7e65f8aa8560@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, May 29, 2017 at 12:04 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 28/05/17 20:29, Luc Van Oostenryck wrote:
>> The goal of this series is to speedup the testsuite,
>> mainly by avoiding to unneedlessly spawn child processes.
>>
>> The resulting speedup here is over 2.5, which is quite appreciable.
>
> I would have liked to try these out, particularly on cygwin, but I
> could not get them to apply. (patch #4 has a line: 'rm -f $file.{error,output}.{expected,got,diff}' in the context which I don't have).
>
> I was attempting to apply on top of 'sparse-next-20170516'.
> Should I apply to a different branch?
> Were they built on a branch I don't have?

Ah yes, sorry for that.
It should be applied on top of the next sparse-next but Chris hasn't yet
pulled it.

If you wish you can directly use the branch on my github tree:
        git://github.com/lucvoo/sparse.git testsuite-faster

-- Luc
