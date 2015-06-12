From: Azat Khuzhin <a3at.mail@gmail.com>
Subject: Re: [PATCH 1/2] sparse, llvm: compile: skip function prototypes to
 avoid SIGSEGV
Date: Fri, 12 Jun 2015 08:18:06 +0300
Message-ID: <20150612051806.GD29381@azat>
References: <1431815545-21250-1-git-send-email-a3at.mail@gmail.com>
 <1431815545-21250-2-git-send-email-a3at.mail@gmail.com>
 <CANeU7Q=VgqNhSDdQzF1H0pUjs78axBGz0VLjG2RY80P6aFh-_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34802 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbFLFSL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 12 Jun 2015 01:18:11 -0400
Received: by lbcmx3 with SMTP id mx3so13705749lbc.1
        for <linux-sparse@vger.kernel.org>; Thu, 11 Jun 2015 22:18:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=VgqNhSDdQzF1H0pUjs78axBGz0VLjG2RY80P6aFh-_A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse ML <linux-sparse@vger.kernel.org>

On Thu, Jun 11, 2015 at 05:50:16PM -0700, Christopher Li wrote:
> On Sat, May 16, 2015 at 3:32 PM, Azat Khuzhin <a3at.mail@gmail.com> wrote:
> >
> > You can't pass function to LLVMConstNull(), according to
> > Constant::getNullValue, and sparse-llvm already handle functions differently
> > (i.e. there will be no call to LLVMConstNull(), but this is not true for
> 
> 
> The patch looks good. I am applying it. However I just notice that you did not
> provide the signed-off-by line.
> 
> Can you resend both patch with the signed off line?

Sure, I'm doing this right now!

Thanks,
Azat.
