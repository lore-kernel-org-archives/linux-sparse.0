From: "Damien Lespiau" <damien.lespiau@gmail.com>
Subject: Re: [PATCH] Beautify all & install Makefile targets
Date: Tue, 22 May 2007 20:28:11 +0200
Message-ID: <cbf3148c0705221128s884ad1l9a0986cee98445bb@mail.gmail.com>
References: <11796983862564-git-send-email-damien.lespiau@gmail.com>
	 <4650E944.1060506@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:54064 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419AbXEVS2M (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 14:28:12 -0400
Received: by wx-out-0506.google.com with SMTP id h29so317465wxd
        for <linux-sparse@vger.kernel.org>; Tue, 22 May 2007 11:28:11 -0700 (PDT)
In-Reply-To: <4650E944.1060506@freedesktop.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

> I'd also like to hear from other people on whether or not they prefer this
> style of output.  It doesn't matter much to me either way.

That won't prevent me from resending a more decent patch :p

> > +     QUIET_LD       = @echo    '   ' LD'      '$@;
>
> This always seems misleading to me, given that the corresponding rules run CC,
> not LD.

Well, calling the linker through gcc front-end does not change the fact
that we are linking. To me CC or LD are just saying we are compiling
or linking.

I'll resend a patch, trying to take care of your comments.

-- 
Damien
