From: Christopher Li <sparse@chrisli.org>
Subject: Re: Patch: add __builtin_stpcpy and __sync_synchronize to builtin functions
Date: Thu, 15 Mar 2012 13:02:21 -0700
Message-ID: <CANeU7Qk8yxY_M_xDunYYV0D2h35AMFO4L2CrqXHCvp8iEWGcAg@mail.gmail.com>
References: <1331820943.2720.5.camel@par-r81vxc7.par.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52298 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032213Ab2COUCW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 15 Mar 2012 16:02:22 -0400
Received: by ghrr11 with SMTP id r11so3465860ghr.19
        for <linux-sparse@vger.kernel.org>; Thu, 15 Mar 2012 13:02:21 -0700 (PDT)
In-Reply-To: <1331820943.2720.5.camel@par-r81vxc7.par.novell.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Frederic Crozat <fcrozat@suse.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Mar 15, 2012 at 7:15 AM, Frederic Crozat <fcrozat@suse.com> wrote:
> Hi,
>
> while working on integrating sparse checks in systemd, I noticed some
> builtin functions need to be added to sparse list. See attached patch
> for the fix.

It looks fine. I will apply it.

>
> I've also noted patch from Pekka Enberg
> (http://www.spinics.net/lists/linux-sparse/msg02520.html ) is still
> needed when running sparse on x86-64. It would be nice to merge it in
> git.

This one looks fine too. Not sure why I miss it.

Any way, I will apply it as well. Thanks for pointing it out.

Chris
