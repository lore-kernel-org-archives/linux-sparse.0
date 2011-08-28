From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [ANNOUNCE] LLVM backend for Sparse
Date: Sun, 28 Aug 2011 16:51:45 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1108281651330.2689@localhost6.localdomain6>
References: <alpine.DEB.2.00.1108280904070.7603@localhost6.localdomain6> <CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64562 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab1H1Nvy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 09:51:54 -0400
Received: by bke11 with SMTP id 11so3562605bke.19
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 06:51:52 -0700 (PDT)
In-Reply-To: <CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>

On Sun, 28 Aug 2011, Christopher Li wrote:
> I attach a patch to limit g++ usage only to llvm related programs.
> Currently it use g++ to link other sparse programs.

Applied, thanks!
