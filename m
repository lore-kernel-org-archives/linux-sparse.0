From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/3] linearize_statement: split up into helper functions
Date: Sat, 27 Aug 2011 20:24:57 -0700
Message-ID: <CANeU7QkWvUtjduXHDtd2Xk4LWt0CYcy4UUoZoqDX6kPUWiSyPw@mail.gmail.com>
References: <alpine.LFD.2.02.1108271424400.18733@i5.linux-foundation.org>
	<alpine.LFD.2.02.1108271429000.18733@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53417 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1H1DY6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 23:24:58 -0400
Received: by qwk3 with SMTP id 3so2696923qwk.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 20:24:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1108271429000.18733@i5.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

On Sat, Aug 27, 2011 at 2:30 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> The impetus for this was that it was really nasty to debug what went wrong
> when the callchain just had that "linearize_statement()". So not only do
> we avoid a level of indentation, but this actually makes things much
> easier to follow in gdb (at least as long as you don't compile with the
> default -finline-functions and -O2)

Thanks for the patch series. It looks great, will definitely apply.

Chris
