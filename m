From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: extra 'make check' failures on 32bit Linux
Date: Mon, 27 Mar 2017 03:03:43 +0200
Message-ID: <20170327010342.vd34svh3kee43qir@macpro.local>
References: <806988fb-6e3c-872b-d7ab-282336f67f73@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36678 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbdC0BDs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Mar 2017 21:03:48 -0400
Received: by mail-wr0-f177.google.com with SMTP id w11so21930094wrc.3
        for <linux-sparse@vger.kernel.org>; Sun, 26 Mar 2017 18:03:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <806988fb-6e3c-872b-d7ab-282336f67f73@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Mar 26, 2017 at 11:21:44PM +0100, Ramsay Jones wrote:
> Hi Christopher, Luc,
> 
> On occasion I build sparse on 32-bit Linux and I have noticed, for some
> weeks now, unexpected test failures. I have been meaning to take a look
> at fixing these failures, but I just haven't had the time ... :(

>   ...
>   
>        TEST     division constants (div.c)
>   error: actual error text does not match expected error text.
>   error: see div.c.error.* for further investigation.
>   --- div.c.error.expected	2017-03-26 18:26:04.142887258 +0100
>   +++ div.c.error.got	2017-03-26 18:26:04.142887258 +0100
>   @@ -2,8 +2,6 @@
>    div.c:4:20: warning: division by zero
>    div.c:5:22: warning: division by zero
>    div.c:7:25: warning: constant integer operation overflow
>   -div.c:8:27: warning: constant integer operation overflow
>    div.c:9:34: warning: constant integer operation overflow
>    div.c:11:25: warning: constant integer operation overflow
>   -div.c:12:27: warning: constant integer operation overflow
>    div.c:13:34: warning: constant integer operation overflow
>   ...

It's not very clear to me what is the cause of this error.
Have you only since some weeks (then I think it's since the
we define __SIZEOF_POINTER__) or is it older (then I think
it exists since quite a long time)?

-- Luc
