From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Mon, 29 Aug 2011 17:42:49 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1108291741350.12047@localhost6.localdomain6>
References: <4E5495C9.6050207@kernel.org> <CA+55aFwLLn30qohqJeBZLVUYWLKUnbBxnL9u+v=4Fx8TpxDQUQ@mail.gmail.com> <4E55F33C.50203@kernel.org> <CAOJsxLF-=mPSdKLwmc61ZRTQrLGjPTUwVw+PqabYvGKVRwh9sQ@mail.gmail.com> <CAOJsxLFMz7fs4ySkizHk43a0fz9VKS5ReWXoJa8cy2AQ6iwRng@mail.gmail.com>
 <CA+55aFywG3vBA87W2h1f=-H144MTZesEwp5jVu8ndyBfLX7Sbg@mail.gmail.com> <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6> <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com> <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6>
 <4E58731A.7010708@garzik.org> <alpine.DEB.2.00.1108271104440.2570@localhost6.localdomain6> <4E58AE9E.1090601@garzik.org> <4E59478C.9000504@garzik.org> <alpine.DEB.2.00.1108280815530.2734@localhost6.localdomain6> <4E5A129F.1090801@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34578 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab1H2Om5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 10:42:57 -0400
Received: by bke11 with SMTP id 11so4213883bke.19
        for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 07:42:56 -0700 (PDT)
In-Reply-To: <4E5A129F.1090801@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, 28 Aug 2011, Jeff Garzik wrote:
> * it will soon be necessary to pay more attention to target-specific details. 
> we need some mechanism for specifying i386, x86-64, etc. so that we may fill 
> in bits_in_pointer and similar values properly.  This may involve some sparse 
> hacking IIRC, because sparse (used to be?) largely hardcoded to use i386 
> target values when checking.  Or maybe this is already done, and I just am 
> ignorant of that area of the code.


Can you think of anything else except target.c that needs to be fixed in 
sparse?

 			Pekka
