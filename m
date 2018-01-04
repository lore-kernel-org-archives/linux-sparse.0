From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse ctags segfaults (latest git)
Date: Fri, 5 Jan 2018 01:43:30 +0800
Message-ID: <CANeU7QmEdM-Cu-H3-tX9bbeG0VoTK3h4GtdM8vRNYkUUCReVzQ@mail.gmail.com>
References: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:38732 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbeADRnc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 Jan 2018 12:43:32 -0500
Received: by mail-yw0-f170.google.com with SMTP id x199so860681ywg.5
        for <linux-sparse@vger.kernel.org>; Thu, 04 Jan 2018 09:43:31 -0800 (PST)
In-Reply-To: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: foobar <foobar@redchan.it>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jan 2, 2018 at 6:58 AM, foobar <foobar@redchan.it> wrote:
> git version 08890dcd7cc77b5d776768775484ed60fc23f08e
> linux x64_64 (using musl libc)
>
> gdb --args ./ctags ctags.c
>
> Reading symbols from /home/foobar/sparse/ctags...done.
> (gdb) r
> Starting program: /home/foobar/sparse/./ctags ctags.c
> warning: no loadable sections found in added symbol-file system-supplied DSO at 0x7ffff7ff9000
> /usr/include/stdint.h:105:5: warning: constant 0xffffffffffffffffu is so big it is unsigned long
> /usr/include/stdint.h:105:20: warning: constant 0xffffffffffffffffu is so big it is unsigned long

Thanks for the bug report.

Chris
