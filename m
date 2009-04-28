From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sparse: Why test-parse shows "+=" as a store?
Date: Mon, 27 Apr 2009 20:24:51 -0400
Message-ID: <49F64CD3.2040100@garzik.org>
References: <49F4C99A.7020208@garzik.org> <70318cbf0904262304j3d85f839o5fbd37d48f0e79e8@mail.gmail.com> <49F588BA.4060503@garzik.org> <70318cbf0904271045s6b2e300evad7f6ec05dd96b3f@mail.gmail.com> <49F6386D.5050809@garzik.org> <70318cbf0904271639w20cc0300ge2e3ac0638c698dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58256 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322AbZD1AYx (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 20:24:53 -0400
In-Reply-To: <70318cbf0904271639w20cc0300ge2e3ac0638c698dd@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

Christopher Li wrote:
> On Mon, Apr 27, 2009 at 3:57 PM, Jeff Garzik <jeff@garzik.org> wrote:
>> Well, I'll tell you what.  If you or somebody else wants to volunteer to
>> make key sparse & linearize changes, then I will work on a linearize LLVM
>> backend.
>>
>> Absent that, the motivation is lower, considering I have a current, working
>> approach that does not require any upstream changes.
> 
> Unless I am missing some thing. I don't see your back end generate
> GET_ELEMENT_PTR instruction in LLVM. So you should be able to use existing
> linearize instruction to generate what your patch does, without up stream
> changes.

That is because the v2 backend is largely integer only, and did not do 
much with structs.


> To generate GET_ELEMENT_PTR properly require upstream changes, but
> your patch doesn't do that either.

Quoting the email to which you replied:  "I just managed to figure out[...]"

There are many changes beyond the v2 patch posted already, but this is 
only at the "confirmed a theory with test code" stage, not yet even 
included in any local repository.

	Jeff



