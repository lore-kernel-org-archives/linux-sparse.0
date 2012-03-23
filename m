From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC/PATCH 1/2] sparse: Fix including glibc headers on x86-64
Date: Fri, 23 Mar 2012 01:59:10 -0700
Message-ID: <CANeU7Q=h1egUD1cSpNwmAnemXPTa0k0OrKQOY6Rhow_5hb1hYA@mail.gmail.com>
References: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34067 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757764Ab2CWI7L (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2012 04:59:11 -0400
Received: by gghe5 with SMTP id e5so2537033ggh.19
        for <linux-sparse@vger.kernel.org>; Fri, 23 Mar 2012 01:59:10 -0700 (PDT)
In-Reply-To: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: penberg@cs.helsinki.fi
Cc: linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Crozat <fcrozat@suse.com>

On Sun, Oct 23, 2011 at 5:36 AM,  <penberg@cs.helsinki.fi> wrote:
> From: Pekka Enberg <penberg@kernel.org>
>
> Sparse treats code as 32-bit which causes problems for userspace projects on
> x86-64 Fedora if you don't have the 32-bit glibc compat package installed
> ("glib-devel.i686"):

A blast from the past. Thanks Frederic for reminding me this one.

> +
> +#ifdef __x86_64
> +       add_pre_buffer("#weak_define x86_64 1\n");
> +       add_pre_buffer("#weak_define __x86_64 1\n");
> +       add_pre_buffer("#weak_define __x86_64__ 1\n");
> +#endif
>  }

I just realized that this patch has the unwanted side effect that,
even if you try to define 32 bit compile in 64 bit Linux, the __x86_64__ will
still be there. The weak define only avoid the conflict of defining
the __x86_64__
the second time. It does not solve the case where __x86_64__ shouldn't
be there.

The better way seems to be parsing -m32 and -m64 then set the
__x86_64__ accordingly.

Chris
