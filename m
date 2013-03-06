From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC PATCH] sparse: Add cmd line --version option
Date: Wed, 6 Mar 2013 13:19:12 -0800
Message-ID: <CANeU7QmO=RoOraB0u52CLhzBbksw83SWR74S9-jHoN7xbf-W9w@mail.gmail.com>
References: <1362590578.1759.48.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:53482 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab3CFVTM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Mar 2013 16:19:12 -0500
Received: by mail-ob0-f171.google.com with SMTP id x4so3914555obh.30
        for <linux-sparse@vger.kernel.org>; Wed, 06 Mar 2013 13:19:12 -0800 (PST)
In-Reply-To: <1362590578.1759.48.camel@joe-AO722>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Mar 6, 2013 at 9:22 AM, Joe Perches <joe@perches.com> wrote:
> There's no current way to know the version
> of sparse.  Add --version to see it.

Hi Joe,

Thanks for the patch.

I agree that this the "--version" switch has its value.
However, I don't like using "die" to print out the version string.
I see no reason why sparse should exit with error for printing
out version string. For example, gcc does not do that.

If you don't want to recompile lib.c every time, you can make
a version.c to store the version string.

Another thing is nice to have, but not required.
You consider to give "--" its own handing function. It is bit odd
seeing the "-version" mix with other switch command. The
patch is simpler. Either way is fine with me.

The exit code need to be fixed.

I will apply the patch once you fix the exit code.

Chris
