From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] Fix 'already_tokenized()' performance problem
Date: Tue, 19 Apr 2011 14:52:47 -0700
Message-ID: <BANLkTi=5mCuOWYZ_7Cav2jbLZ1DVUyyjag@mail.gmail.com>
References: <alpine.LFD.2.02.1104191108330.21972@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57056 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab1DSVwr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Apr 2011 17:52:47 -0400
Received: by vxi39 with SMTP id 39so118002vxi.19
        for <linux-sparse@vger.kernel.org>; Tue, 19 Apr 2011 14:52:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1104191108330.21972@i5.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org

Very nice patch. Simple and clean.

Applied and pushed.


On Tue, Apr 19, 2011 at 11:12 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This series of two trivial patches makes 'already_tokenized()' go away
> from profiles of a kernel build with C=2, shaving about 3-4% off the time
> for me.

I am suppressed that you can get 3-4% from just comparing the stream names.
Last time I try to optimized that nextchar() and nextchar_slow()
because Al complains
the tab character force the slow path, I haven't seen some thing like
1% difference.
So I leave it alone.

Thanks for the patch.

Chris
