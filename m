From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Mon, 21 Nov 2016 10:38:46 +0800
Message-ID: <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33719 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752763AbcKUCir (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Nov 2016 21:38:47 -0500
Received: by mail-io0-f194.google.com with SMTP id j92so5032575ioi.0
        for <linux-sparse@vger.kernel.org>; Sun, 20 Nov 2016 18:38:47 -0800 (PST)
In-Reply-To: <20161117095503.8754-1-johannes@sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 17, 2016 at 5:55 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> Since gcc does this, it's apparently valid to write
>
>  switch (x) {
>  case __builtin_bswap16(12):
>    break;
>  }
>

Applied. Thanks for the patch. That will definite stop a lot of warning.

There is other possible __builtin_xxx() function gcc expected to get a
const result
when the input arguments are constant.  Ideally, we should be able to
mark __builtin_bswap16
as a special constant "pass through" function. So during the
evaluation and constant propagation,
sparse can pass through the native __builtin_xxx() call to get the
const result. In other words,
sparse shouldn't need to implement "__builtin_bswap16()" by itself. It
can just call to the gcc
one to get the result. Then we can treat all other similar
__builtin_xxx function the same way.

That is a separate patch though.

Chris
