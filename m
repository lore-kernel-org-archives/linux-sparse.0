From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: Warnings on global symbols accessed only from assembly code
Date: Fri, 12 Feb 2010 03:47:09 +0200
Message-ID: <20100212014709.GA10748@laptop>
References: <20100212000052.GA6837@laptop> <70318cbf1002111706n7011eecpdaeb8bb691f95087@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:9861 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340Ab0BLBrN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Feb 2010 20:47:13 -0500
Received: by fg-out-1718.google.com with SMTP id l26so38232fgb.1
        for <linux-sparse@vger.kernel.org>; Thu, 11 Feb 2010 17:47:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <70318cbf1002111706n7011eecpdaeb8bb691f95087@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Thu, Feb 11, 2010 at 05:06:56PM -0800, Christopher Li wrote:
> On Thu, Feb 11, 2010 at 4:00 PM, Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> [..]
> > The reason is that a declaration for such methods - which are usually
> > bootstrap ones - can given the false impression of being used by some
> > C code 'somewhere'.
> 
> Sparse does not care about who call those function, C code or asm code.
> Sparse don't not actually link the program so it can't know this symbol is
> actually externally used or not.
> 
> Personally, I don't see why you can't declare those functions even
> if they are called from asm.
>

Yes, the declarations are doable of course, but they'll be for-the-sake-
-of-sparse thing.

The case I faced was kernel's main entrance C method which should only be
jumped to from bootstrap asm code. I think a declaration in such case will
only give bogus function usage impressions.

> > Unfortunately the current `-Wno-decl' solution is a bit extreme: it
> > turns off a very useful sparse feature (by design).
> 
> Right, the problem is that sparse can't tell which functions are used in
> asm files and only skip warning on those.
>

Would proposing an __attribute__ for such case be accepted in concept?

> Chris

Thanks a lot

-- 
Darwish
http://darwish.07.googlepages.com
