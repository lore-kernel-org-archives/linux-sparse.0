From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Sun, 28 Aug 2011 06:04:15 -0400
Message-ID: <4E5A129F.1090801@garzik.org>
References: <4E5495C9.6050207@kernel.org> <CA+55aFwLLn30qohqJeBZLVUYWLKUnbBxnL9u+v=4Fx8TpxDQUQ@mail.gmail.com> <4E55F33C.50203@kernel.org> <CAOJsxLF-=mPSdKLwmc61ZRTQrLGjPTUwVw+PqabYvGKVRwh9sQ@mail.gmail.com> <CAOJsxLFMz7fs4ySkizHk43a0fz9VKS5ReWXoJa8cy2AQ6iwRng@mail.gmail.com> <CA+55aFywG3vBA87W2h1f=-H144MTZesEwp5jVu8ndyBfLX7Sbg@mail.gmail.com> <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6> <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com> <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6> <4E58731A.7010708@garzik.org> <alpine.DEB.2.00.1108271104440.2570@localhost6.localdomain6> <4E58AE9E.1090601@garzik.org> <4E59478C.9000504@garzik.org> <alpine.DEB.2.00.1108280815530.2734@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45670 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab1H1KES (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 06:04:18 -0400
Received: by qwk3 with SMTP id 3so2768292qwk.19
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 03:04:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1108280815530.2734@localhost6.localdomain6>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 08/28/2011 01:16 AM, Pekka Enberg wrote:
> On Sat, 27 Aug 2011, Jeff Garzik wrote:
>> OK, I lied. Function call support (OP_CALL) sent your way via github
>> pull request.
>
> Pulled, thanks!

(added list to CC)

Just sent another, tiny pull req.  That's it for tonight.

Random thoughts / backend status:

* it will soon be necessary to pay more attention to target-specific 
details.  we need some mechanism for specifying i386, x86-64, etc. so 
that we may fill in bits_in_pointer and similar values properly.  This 
may involve some sparse hacking IIRC, because sparse (used to be?) 
largely hardcoded to use i386 target values when checking.  Or maybe 
this is already done, and I just am ignorant of that area of the code.

* playing with some simple loop test cases, we are blocked on properly 
listing out all phi's in an OP_PHI.  sparse correctly sends us 
OP_PHISOURCE, and test-linearize output looks good, but if the phisrc is 
from a succeeding basic block, we may lack 'priv' necessary to fill in 
LLVMValueRef required by LLVM phi machinery.

* my development workflow is very simple.  create testcase; look at 
test-linearize output; observe how linearize.c's show_instruction() and 
show_pseudo() walk their data structures; copy this into sparse-llvm.

* it would be nice to get "printf(hello world)" working all the way 
through sparsec.

* need to start integrating struct support.  LLVM has a type system 
where one defines data structures in the IR, then uses 'getelementptr' 
LLVM instruction to build addresses for complex load/store operations. 
The Linux kernel uses a lot of function calls (indirect branches) from 
values buried deep within a struct.

