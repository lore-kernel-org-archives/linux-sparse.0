From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: add __builtin_va_arg_pack() and __builtin_va_arg_pack_len()
Date: Thu, 18 Jul 2013 19:49:59 -0700
Message-ID: <CANeU7Qn5LFSKN9+vX+yGVovbcWNMmJT4HU6Se4ObsoJHh851fA@mail.gmail.com>
References: <20130718084743.727666bc@tlielax.poochiereds.net>
	<1374161799-2929-1-git-send-email-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:41525 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759561Ab3GSCt7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Jul 2013 22:49:59 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so4621609obb.18
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jul 2013 19:49:59 -0700 (PDT)
In-Reply-To: <1374161799-2929-1-git-send-email-jlayton@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Jul 18, 2013 at 8:36 AM, Jeff Layton <jlayton@redhat.com> wrote:
> this patch stops sparse from complaining about them not being defined:
>
>     /usr/include/bits/stdio2.h:98:25: error: undefined identifier '__builtin_va_arg_pack'
>     /usr/include/bits/stdio2.h:98:25: error: not a function <noident>
>
> Probably, there is some better way to do this that actually validates
> this function, but I'm not clear on how to do it.
>

Please add a test case for the typical usage case of __buildin_va_arg_pack()
and __builtin_va_arg_pack_len(). At the very least, it needs to cover the real
world breakage that bother you enough to submit a patch.

The patch looks good otherwise.

Thanks

Chris
