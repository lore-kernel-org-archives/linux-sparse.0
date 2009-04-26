From: Jeff Garzik <jeff@garzik.org>
Subject: sparse: Why test-parse shows "+=" as a store?
Date: Sun, 26 Apr 2009 16:52:42 -0400
Message-ID: <49F4C99A.7020208@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49439 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097AbZDZUwp (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 26 Apr 2009 16:52:45 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Al Viro <viro@ZenIV.linux.org.uk>


Consider this testcase:

int bloo = 0;

void inc_bloo(void)
{
	bloo += 2;
}

int get_bloo(void)
{
	return bloo;
}

test-parse (and its derivatives, compile-i386 and s2l-gen) parse the 
above "bloo += 2" as a simple assignment "bloo = 2".

Any idea why?  I'm not sure if this is a tree-walker bug or something 
from the parsing.  The test-parse output is below...

	Jeff




> hello.c:2:5: warning: symbol 'bloo' was not declared. Should it be static?
> hello.c:4:6: warning: symbol 'inc_bloo' was not declared. Should it be static?
> hello.c:9:5: warning: symbol 'get_bloo' was not declared. Should it be static?
> 
> .align 4
> int [signed] [addressable] [toplevel] [assigned] bloo
>  = 
> 	movi.32		v1,$0
> , 
> void extern [addressable] [toplevel] inc_bloo( ... )
> 	movi.32		v2,$2
> 	movi.32		v3,$bloo
> 	st.32		v2,[v3]
> .L0x7f0b0b4a2030:
> 	addi.32		v4,vFP,$offsetof(return:0x7f0b0b4a2030)
> 	ld.-1		v5,[v4]
> 	mov.-1		retval,5
> 	ret
> , 
> .align 4
> int extern [signed] [addressable] [toplevel] get_bloo( ... )
> 	movi.32		v6,$bloo
> 	ld.32		v7,[v6]
> 	addi.32		v8,vFP,$offsetof(return:0x7f0b0b4a23b0)
> 	st.32		v7,[v8]
> 	ret		(0x7f0b0b4a23b0)
> .L0x7f0b0b4a23b0:
> 	addi.32		v9,vFP,$offsetof(return:0x7f0b0b4a23b0)
> 	ld.32		v10,[v9]
> 	mov.32		retval,10
> 	ret
> 

