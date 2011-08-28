From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Sun, 28 Aug 2011 15:33:34 -0400
Message-ID: <4E5A980E.70308@garzik.org>
References: <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6> <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com> <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6> <4E58731A.7010708@garzik.org> <alpine.DEB.2.00.1108271104440.2570@localhost6.localdomain6> <4E58AE9E.1090601@garzik.org> <4E59478C.9000504@garzik.org> <alpine.DEB.2.00.1108280815530.2734@localhost6.localdomain6> <4E5A129F.1090801@garzik.org> <CA+55aFw5VYSXduhXrtQx5CM4ubvOoHtrbyF74Y_wOQpBxE6Vmw@mail.gmail.com> <20110828175255.GA10203@leaf> <CA+55aFxm9vB8mFFy7y4pctyOeOE=8CjYUvL1mDdOnp2CihPd9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41076 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab1H1Tdg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 15:33:36 -0400
Received: by qwk3 with SMTP id 3so2916547qwk.19
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 12:33:35 -0700 (PDT)
In-Reply-To: <CA+55aFxm9vB8mFFy7y4pctyOeOE=8CjYUvL1mDdOnp2CihPd9w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Pekka Enberg <penberg@kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 08/28/2011 02:23 PM, Linus Torvalds wrote:
> On Sun, Aug 28, 2011 at 10:52 AM, Josh Triplett<josh@joshtriplett.org>  wrote:
>>>
>>> You should consider all types to be just "blocks of memory", and
>>> sparse has already calculated all offsets etc for you. As far as LLVM
>>> is concerned, the memory has no structure, it's just a blob.
>>
>> I suspect LLVM's optimization passes won't particularly care for that
>> approach.
>
> That's fine. We've already done the CSE and alias analysis on the
> thing. And as mentioned, trying to turn overlapping (or partial)
> accesses into some "named accesses" is just *wrong*. They weren't
> named in the C code either. They are accesses through pointer
> arithmetic. Trying to make them be somehow named would just be crazy.

LLVM just cares about layout.

It does not care about naming (or lack thereof).  Nobody/nothing is 
trying to make them named.

	Jeff


