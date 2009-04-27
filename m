From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sparse: Why test-parse shows "+=" as a store?
Date: Mon, 27 Apr 2009 18:57:49 -0400
Message-ID: <49F6386D.5050809@garzik.org>
References: <49F4C99A.7020208@garzik.org>	 <70318cbf0904262304j3d85f839o5fbd37d48f0e79e8@mail.gmail.com>	 <49F588BA.4060503@garzik.org> <70318cbf0904271045s6b2e300evad7f6ec05dd96b3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38714 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbZD0W5w (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 18:57:52 -0400
In-Reply-To: <70318cbf0904271045s6b2e300evad7f6ec05dd96b3f@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

Christopher Li wrote:
> On Mon, Apr 27, 2009 at 3:28 AM, Jeff Garzik <jeff@garzik.org> wrote:
>> Use of test-parsing eliminates my code as a factor -- which was why I
>> mentioned it.
>>
>> Oh well, I will figure it out.
> 
> Let me take a look at your code as well. Maybe I can spot some thing.
> 
>> linearized output is too low level for LLVM in several cases.  The shifts in
>> linearize_load_gen() and linearize_store_gen() get in the way, for example.
>>  Having sparse calculate struct offsets itself is also not desirable: in
>> order to use LLVM's getelementptr instruction, you should instead give LLVM
>> the type information and member indices, and let it figure out the address
>> calculation from there.
> 
> Right. I think GET_ELEMENT_PTR is the only part missing. I think it is
> a relative small change to preserve the structure laid, comparing to rewriting
> everything.
> 
> BTW, I don't think linearize lost that structure information. It
> happens way before
> linearize stage. Sparse converts the structure member access into void pointer
> add very early on. If you want to preserve that information,
> you need to change more than just linearize code. So linearize is not the
> blocking factor here. It needs upstream change as well.

I just managed to figure out how to locate, enumerate and declare sparse 
SYM_STRUCT to LLVM backend, in s2l-gen.c, without any upstream changes.


>> Thus, use of linearize would imply having to work backwards and recreate
>> information lost during the linearization.
> 
> Or, we can teach sparse to preserve that information in the linearize level.

Well, I'll tell you what.  If you or somebody else wants to volunteer to 
make key sparse & linearize changes, then I will work on a linearize 
LLVM backend.

Absent that, the motivation is lower, considering I have a current, 
working approach that does not require any upstream changes.

	Jeff



