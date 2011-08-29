From: Jeff Garzik <jeff@garzik.org>
Subject: Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Mon, 29 Aug 2011 15:52:24 -0400
Message-ID: <4E5BEDF8.4090907@garzik.org>
References: <4E5495C9.6050207@kernel.org> <CA+55aFwLLn30qohqJeBZLVUYWLKUnbBxnL9u+v=4Fx8TpxDQUQ@mail.gmail.com> <4E55F33C.50203@kernel.org> <CAOJsxLF-=mPSdKLwmc61ZRTQrLGjPTUwVw+PqabYvGKVRwh9sQ@mail.gmail.com> <CAOJsxLFMz7fs4ySkizHk43a0fz9VKS5ReWXoJa8cy2AQ6iwRng@mail.gmail.com> <CA+55aFywG3vBA87W2h1f=-H144MTZesEwp5jVu8ndyBfLX7Sbg@mail.gmail.com> <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6> <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com> <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6> <alpine.DEB.2.00.1108252310490.22479@localhost6.localdomain6> <CA+55aFy3TUT=BFD+Nb9H6uDBhz427kC4tBc+ehQDs6JBggTuHQ@mail.gmail.com> <4E573A3E.6060104@kernel.org> <CA+55aFzbV0OvrtkzbjxvL1tkfF=+6xbBsyWb8XtAcK-YNeKjZw@mail.gmail.com> <alpine.DEB.2.00.1108271214410.14
 365@localhost6.localdomain6> <CA+55aFzbfD4RDe52HCL9mfSYMzFdvP96OiK5ifkfUKNkzjJNrg@mail.gmail.com> <alpine.DEB.2.00.1108292242110.24020@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55309 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566Ab1H2Tw1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 15:52:27 -0400
Received: by qyk34 with SMTP id 34so4041759qyk.19
        for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 12:52:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1108292242110.24020@localhost6.localdomain6>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

On 08/29/2011 03:45 PM, Pekka Enberg wrote:
> However, i'm not 100% sure that's sufficient. Is OP_CAST always
> zero-extend or do we need to check for something specific here?


At a minimum we must deal with pointer casts in there too?

