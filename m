From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [ANNOUNCE] LLVM backend for Sparse
Date: Sun, 28 Aug 2011 17:01:20 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1108281700030.7991@localhost6.localdomain6>
References: <alpine.DEB.2.00.1108280904070.7603@localhost6.localdomain6> <CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58148 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab1H1OB3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 10:01:29 -0400
Received: by bke11 with SMTP id 11so3565794bke.19
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 07:01:28 -0700 (PDT)
In-Reply-To: <CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>

On Sun, 28 Aug 2011, Christopher Li wrote:
> Very impressive. That is some sparse 0.5 material.
> I will start merging it as soon as I release 0.4.4
>
> I play around with it a little bit, It seems choke on the hello
> world program. Shouldn't be hard to fix though.

It's lack of PSEUDO_SYM support. I haven't quite figured out what kind of 
code to generate for that because, frankly, I'm not completely sure what 
it's all about. ;-)

 			Pekka
