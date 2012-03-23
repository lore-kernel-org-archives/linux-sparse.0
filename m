From: Christopher Li <sparse@chrisli.org>
Subject: Re: Patch: add __builtin_stpcpy and __sync_synchronize to builtin functions
Date: Fri, 23 Mar 2012 01:26:29 -0700
Message-ID: <CANeU7QmikoVWVuVo1nWdgADoKD30iTCSirM+S1c9-aRd7hEa0Q@mail.gmail.com>
References: <1331820943.2720.5.camel@par-r81vxc7.par.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55926 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab2CWI0a (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2012 04:26:30 -0400
Received: by yenl12 with SMTP id l12so2516261yen.19
        for <linux-sparse@vger.kernel.org>; Fri, 23 Mar 2012 01:26:29 -0700 (PDT)
In-Reply-To: <1331820943.2720.5.camel@par-r81vxc7.par.novell.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Frederic Crozat <fcrozat@suse.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Mar 15, 2012 at 7:15 AM, Frederic Crozat <fcrozat@suse.com> wrote:
> while working on integrating sparse checks in systemd, I noticed some
> builtin functions need to be added to sparse list. See attached patch
> for the fix.

Catching up my backlogs. I just find out this patch does not have sign off.

Can you add a sign off line please?

Thanks

Chris
