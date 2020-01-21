From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] correct sparcv9 defines
Date: Tue, 21 Jan 2020 01:13:22 +0100
Message-ID: <20200121001322.zikj2xsacqt765fi@ltop.local>
References: <20200120103824.20746-1-john.levon@joyent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39186 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAUAN1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Jan 2020 19:13:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so1165896wmj.4
        for <linux-sparse@vger.kernel.org>; Mon, 20 Jan 2020 16:13:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200120103824.20746-1-john.levon@joyent.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: john.levon@joyent.com
Cc: linux-sparse@vger.kernel.org, Toomas Soome <tsoome@me.com>

On Mon, Jan 20, 2020 at 02:38:24AM -0800, john.levon@joyent.com wrote:
> From: Toomas Soome <tsoome@me.com>
> 
> The SPARCV9 compile check needs to look for __sparcv9 on some systems,
> and should also define "sparc".

Hi.

Thanks for the patch.
Is it possible to have Toomas' Signed-off-by for this patch?
No need to resend the patch, just a reply to this email
saying it's OK is enough.

>  	case MACH_SPARC32:
>  		predefine("__sparc__", 1, "1");
>  		predefine("__sparc", 1, "1");
> +		predefine("sparc", 1, "1");

I'm wondering if there is a real need for this one or if
it's just to reflect what GCC do? I'm a bit reluctant to
add it since it lies in the user's namespace. But I'm fine
to add it if there is a real use case for it (in which case
I'll just slightly change the patch to not predefine it if
one of the ISO dialect is selected (via --std=c99, ...)).

-- Luc
