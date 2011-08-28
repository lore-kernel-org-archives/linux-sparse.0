From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Sun, 28 Aug 2011 06:18:33 -0400
Message-ID: <4E5A15F9.2090007@garzik.org>
References: <4E5495C9.6050207@kernel.org> <CA+55aFwLLn30qohqJeBZLVUYWLKUnbBxnL9u+v=4Fx8TpxDQUQ@mail.gmail.com> <4E55F33C.50203@kernel.org> <CAOJsxLF-=mPSdKLwmc61ZRTQrLGjPTUwVw+PqabYvGKVRwh9sQ@mail.gmail.com> <CAOJsxLFMz7fs4ySkizHk43a0fz9VKS5ReWXoJa8cy2AQ6iwRng@mail.gmail.com> <CA+55aFywG3vBA87W2h1f=-H144MTZesEwp5jVu8ndyBfLX7Sbg@mail.gmail.com> <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6> <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com> <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6> <4E58731A.7010708@garzik.org> <alpine.DEB.2.00.1108271104440.2570@localhost6.localdomain6> <4E58AE9E.1090601@garzik.org> <4E59478C.9000504@garzik.org> <alpine.DEB.2.00.1108280815530.2734@localhost6.localdomain6> <4E5A129F.1090801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64580 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab1H1KSg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 06:18:36 -0400
Received: by qwk3 with SMTP id 3so2771311qwk.19
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 03:18:35 -0700 (PDT)
In-Reply-To: <4E5A129F.1090801@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

> Random thoughts / backend status:

And,

* a "make check" that exercises our known-working backend tests all the 
way through compilation, linking and execution would be VERY helpful. 
i.e. pass values to the binops tests, and make sure we receive expected 
results.

In the early stages, this may mean linking with a gcc-compiled test harness?

