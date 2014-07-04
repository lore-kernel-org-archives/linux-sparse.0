From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Add CLOG option for saving warning
Date: Fri, 4 Jul 2014 00:48:00 -0700
Message-ID: <CANeU7QmT=vzOGd6bBdkr-kNkt7yfzCWQF5QujiwV7Q8Q9hZw=w@mail.gmail.com>
References: <CANeU7Q=a82YmUE49uZ1sOxZn0KGLuktSXuj7YsmUb=wXQEpPXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:42676 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaGDHsA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 Jul 2014 03:48:00 -0400
In-Reply-To: <CANeU7Q=a82YmUE49uZ1sOxZn0KGLuktSXuj7YsmUb=wXQEpPXA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jun 30, 2014 at 1:57 AM, Christopher Li <sparse@chrisli.org> wrote:
>
> Add the CLOG=<logname> option in command line to
> save the sparse warning into individual log file.
>
> Typical usage:
>
> make -j8 C=2 CLOG=<logname>

Any feed back for this change? I want to clarify that this patch
is for the Linux kernel kbuild system, not sparse.

Thanks

Chris
