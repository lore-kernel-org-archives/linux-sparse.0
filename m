From: Ben Pfaff <blp@nicira.com>
Subject: Re: [PATCH] evaluate: Allow sizeof(_Bool) to succeed.
Date: Thu, 12 May 2011 13:48:06 -0700
Message-ID: <20110512204806.GC3371@nicira.com>
References: <1304552394-16280-1-git-send-email-blp@nicira.com>
 <BANLkTikHwADf5Kv5=rQosKcNjsMYM-28wQ@mail.gmail.com>
 <20110509200231.GG2971@nicira.com>
 <BANLkTim26gM+WxF+XSjZTVf+sL9xLLtCoA@mail.gmail.com>
 <20110509204937.GI2971@nicira.com>
 <BANLkTinHEgDw24S=mcE6B7OeirrHk+ZSog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 173-167-111-49-sfba.hfc.comcastbusiness.net ([173.167.111.49]:60875
	"EHLO leadville.nicira.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758620Ab1ELUsI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 12 May 2011 16:48:08 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinHEgDw24S=mcE6B7OeirrHk+ZSog@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Wed, May 11, 2011 at 05:09:42PM -0700, Christopher Li wrote:
> On Mon, May 9, 2011 at 1:49 PM, Ben Pfaff <blp@nicira.com> wrote:
> > I could change my IDL code generator to do something different for
> > this case, but I don't see anything actually wrong with it. ?This
> > userspace code is not performance-critical or sensitive to memory
> > usage, so it's not necessary on the face of it to optimize it.
> 
> Removing the warning will lose the chance to see it on other potential
> problematic usage. If you insist on no warning. You can submit a patch
> to add a switch to disable it. We have a lot of those for fine grain warning
> control. I just don't see this warning can hurt on the kernel checking side.

For now, I've decided to just rewrite code on the Open vSwitch side to
avoid sizeof(_Bool) entirely.  If it becomes a problem again, I'll
submit a -Wno-sizeof-bool patch.

Thanks for considering my reasons.

Ben
