From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] implement constant-folding in __builtin_bswap*()
Date: Thu, 17 Nov 2016 17:39:11 +0800
Message-ID: <CANeU7Qks_yHKNbeGZ7MvxC2MEO4tzehLDL-DEpqZ2+13vQfJxQ@mail.gmail.com>
References: <1470911979-15068-1-git-send-email-johannes@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35676 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbcKQJjN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 04:39:13 -0500
In-Reply-To: <1470911979-15068-1-git-send-email-johannes@sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, Aug 11, 2016 at 6:39 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> Since gcc does this, it's apparently valid to write
>
>  switch (x) {
>  case __builtin_bswap16(12):
>    break;
>  }
>
> but sparse will flag it as an error today.
>
> The constant folding used to be done in the kernel's htons() and
> friends, but due to gcc bugs that isn't done anymore since
> commit 7322dd755e7d ("byteswap: try to avoid __builtin_constant_p
> gcc bug").
>
> To get rid of the sparse errors on every such instance now, just
> add constant folding to __builtin_bswap*() in sparse.

Sorry for the really late review.

This looks good. I would like to apply it. Can you please add some
test case for the function prototype you introduced, just like the way
kernel use it?

Thanks

Chris
