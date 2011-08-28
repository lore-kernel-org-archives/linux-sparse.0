From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Sun, 28 Aug 2011 15:31:45 -0400
Message-ID: <4E5A97A1.4010504@garzik.org>
References: <4E5495C9.6050207@kernel.org> <CA+55aFwLLn30qohqJeBZLVUYWLKUnbBxnL9u+v=4Fx8TpxDQUQ@mail.gmail.com> <4E55F33C.50203@kernel.org> <CAOJsxLF-=mPSdKLwmc61ZRTQrLGjPTUwVw+PqabYvGKVRwh9sQ@mail.gmail.com> <CAOJsxLFMz7fs4ySkizHk43a0fz9VKS5ReWXoJa8cy2AQ6iwRng@mail.gmail.com> <CA+55aFywG3vBA87W2h1f=-H144MTZesEwp5jVu8ndyBfLX7Sbg@mail.gmail.com> <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6> <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com> <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6> <4E58731A.7010708@garzik.org> <alpine.DEB.2.00.1108271104440.2570@localhost6.localdomain6> <4E58AE9E.1090601@garzik.org> <4E59478C.9000504@garzik.org> <alpine.DEB.2.00.1108280815530.2734@localhost6.localdomain6> <4E5A129F.1090801@garzik.org> <CA+55aFw5VYSXduhXrtQ
 x5CM4ubvOoHtrbyF74Y_wOQpBxE6Vmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44010 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1H1Tbs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 15:31:48 -0400
Received: by qyk15 with SMTP id 15so515672qyk.19
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 12:31:47 -0700 (PDT)
In-Reply-To: <CA+55aFw5VYSXduhXrtQx5CM4ubvOoHtrbyF74Y_wOQpBxE6Vmw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pekka Enberg <penberg@kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, josh@joshtriplett.org

On 08/28/2011 01:04 PM, Linus Torvalds wrote:
> On Sun, Aug 28, 2011 at 3:04 AM, Jeff Garzik<jeff@garzik.org>  wrote:
>>
>> * need to start integrating struct support.  LLVM has a type system where
>> one defines data structures in the IR, then uses 'getelementptr' LLVM
>> instruction to build addresses for complex load/store operations. The Linux
>> kernel uses a lot of function calls (indirect branches) from values buried
>> deep within a struct.
>
> You really shouldn't need to do that.
>
> You should consider all types to be just "blocks of memory", and
> sparse has already calculated all offsets etc for you. As far as LLVM
> is concerned, the memory has no structure, it's just a blob.

We _already_ do this in the backend, and LLVM supports 
LOAD-from-random-address just fine:
https://github.com/penberg/sparse-llvm/blob/master/sparse-llvm.c#L325

But that comment was thinking more medium term, supporting multiple 
platforms means properly handling struct layout in memory, which gets 
into the realm of platform-specific ABIs.

It didn't seem like we would want to encode a ton of ABI detail into the 
sparse C front-end.  But it sounds like there will be a lot of ABI 
detail found, if sparse is doing all the memory layout and such.


> Sometimes you cannot even get the "element" name. Look at
> ./test-linearize output of something like this:

Nobody cares about the element name, least of all LLVM.  LLVM provides a 
convenience naming feature, but you don't have to use that.

ABI-dictated memory layout is the main detail to get right, across 
platforms.

	Jeff



