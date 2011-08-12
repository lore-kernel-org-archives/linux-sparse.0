From: Dan Carpenter <error27@gmail.com>
Subject: Re: [RFC PATCH 0/2] check for identical exprs on LHS and RHS of '&&'
Date: Fri, 12 Aug 2011 22:34:32 +0300
Message-ID: <20110812193432.GR3777@shale.localdomain>
References: <1312967235-23817-1-git-send-email-chrisf@ijw.co.nz>
 <20110810174423.GA6677@leaf>
 <20110810174615.GO2203@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:64022 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab1HLTgl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 12 Aug 2011 15:36:41 -0400
Received: by iye16 with SMTP id 16so2109189iye.1
        for <linux-sparse@vger.kernel.org>; Fri, 12 Aug 2011 12:36:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110810174615.GO2203@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Josh Triplett <josh@joshtriplett.org>, Chris Forbes <chrisf@ijw.co.nz>, linux-sparse@vger.kernel.org

On Wed, Aug 10, 2011 at 06:46:15PM +0100, Al Viro wrote:
> On Wed, Aug 10, 2011 at 10:44:23AM -0700, Josh Triplett wrote:
> 
> > How about checking for the same expression multiple times in a single
> > block of | or & expressions?  (flag1 | flag2 | flag2) seems like a
> > likely copy/paste error.
> 
> ... or result of macro expansion.

In Smatch, we store where all the macros are when we run the
preprocessor.  Then for some checks we check if there was a macro at
&expr->pos to see if it's inside a macro, and if so then the error is
suppressed.

For example, Smatch prints an error if you dereference a variable and
then later check it for NULL.  But if the check is inside a macro the
error gets suppressed.

    foo->bar;
    if (foo) { ...  <-- most likely an error.

    foo->bar;
    some_macro_that_checks_for_null(foo);  <-- not an error.

regards,
dan carpenter
