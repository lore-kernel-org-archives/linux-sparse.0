From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] correct sparcv9 defines
Date: Wed, 22 Jan 2020 23:48:01 +0100
Message-ID: <20200122224801.piocizxa45ejy3zg@ltop.local>
References: <20200120103824.20746-1-john.levon@joyent.com>
 <20200121001322.zikj2xsacqt765fi@ltop.local>
 <BFD5AC88-E262-4579-BBD4-3C2BBBEAEBF9@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50964 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVWsG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Jan 2020 17:48:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so491898wmb.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jan 2020 14:48:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <BFD5AC88-E262-4579-BBD4-3C2BBBEAEBF9@me.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Toomas Soome <tsoome@me.com>
Cc: John Levon <john.levon@joyent.com>, linux-sparse@vger.kernel.org

On Wed, Jan 22, 2020 at 12:53:58PM +0200, Toomas Soome wrote:
> > On 21. Jan 2020, at 02:13, Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
> > 
> > Thanks for the patch.
> > Is it possible to have Toomas' Signed-off-by for this patch?
> > No need to resend the patch, just a reply to this email
> > saying it's OK is enough.
> 
> OK by me:)
> 
> > 
> >> 	case MACH_SPARC32:
> >> 		predefine("__sparc__", 1, "1");
> >> 		predefine("__sparc", 1, "1");
> >> +		predefine("sparc", 1, "1");
> > 
> > I'm wondering if there is a real need for this one or if
> > it's just to reflect what GCC do? I'm a bit reluctant to
> > add it since it lies in the user's namespace. But I'm fine
> > to add it if there is a real use case for it (in which case
> > I'll just slightly change the patch to not predefine it if
> > one of the ISO dialect is selected (via --std=c99, ...)).
> > 
> 
> 
> The problem is that gcc does define those symbols and the code is using them, hence smatch should behave the same:

OK, fine for me if the symbol is effectively used.
This patch and John's are applied and pushed with some adaptations
for a related pending branch I merged first.

Thanks,
-- Luc
