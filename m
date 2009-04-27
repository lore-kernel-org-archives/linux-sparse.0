From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sparse: Why test-parse shows "+=" as a store?
Date: Mon, 27 Apr 2009 06:28:10 -0400
Message-ID: <49F588BA.4060503@garzik.org>
References: <49F4C99A.7020208@garzik.org> <70318cbf0904262304j3d85f839o5fbd37d48f0e79e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37112 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbZD0K2O (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 06:28:14 -0400
In-Reply-To: <70318cbf0904262304j3d85f839o5fbd37d48f0e79e8@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

Christopher Li wrote:
> On Sun, Apr 26, 2009 at 1:52 PM, Jeff Garzik <jeff@garzik.org> wrote:
>> Consider this testcase:
>>
>> int bloo = 0;
>>
>> void inc_bloo(void)
>> {
>>        bloo += 2;
>> }
>>
> 
> test-linearize show:
> 
> inc_bloo:
> .L0x7fc013df7010:
> 	<entry-point>
> 	load.32     %r1 <- 0[bloo]
> 	add.32      %r3 <- %r1, $2
> 	store.32    %r3 -> 0[bloo]
> 	ret
> 
> 
> get_bloo:
> .L0x7fc013df70a0:
> 	<entry-point>
> 	load.32     %r5 <- 0[bloo]
> 	ret.32      %r5
> 
>> Any idea why?  I'm not sure if this is a tree-walker bug or something from
>> the parsing.  The test-parse output is below...
> 
> So obvious the parser is correct and I will blame your code :-).

I did not write test-parsing / show_symbol_list().

Use of test-parsing eliminates my code as a factor -- which was why I 
mentioned it.

Oh well, I will figure it out.


> This bring the points that you really should make your LLVM converter
> base on the linearized byte code. Being able to convert to LLVM
> byte code is actually one of my consideration when I hack on the linearized
> back end back then. Look, there is even reserved an opcode for
> GET_ELEMENT_PTR. If there is some thing need to change to the linearized
> back end to make this happen, I am glad to do it.
> 
> But I don't want to have yet another linearized equivalent code base in
> sparse. This is duplicated effort. Bugs will need to fix in both place.
> I am pretty sure using the linearized back end will greatly simplify
> your LLVM byte code generation.
> 
> Do you want to give it a try?

linearized output is too low level for LLVM in several cases.  The 
shifts in linearize_load_gen() and linearize_store_gen() get in the way, 
for example.  Having sparse calculate struct offsets itself is also not 
desirable: in order to use LLVM's getelementptr instruction, you should 
instead give LLVM the type information and member indices, and let it 
figure out the address calculation from there.

Thus, use of linearize would imply having to work backwards and recreate 
information lost during the linearization.

The general idea with LLVM bitcode is to pass it type information, and 
it will ensure that bitfields are handled properly, structs are laid out 
and padded properly, function return types handled, etc.  LLVM handles 
all the address generation for us, once we give it enough type info.

	Jeff



