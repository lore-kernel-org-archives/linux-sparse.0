From: "Robert Catherall" <Robert.Catherall@arm.com>
Subject: bitwise with memcpy and void*
Date: Sat, 11 Jul 2009 17:47:32 +0100
Message-ID: <DD2D1CDF962D7346A5B0E5EE9CA3612711422805@ZIPPY.Emea.Arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:47147 "EHLO
	new-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751123AbZGKRQz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 Jul 2009 13:16:55 -0400
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by new-admin0.cambridge.arm.com (8.13.8+Sun/8.13.8) with ESMTP id n6BGlYUE021648
	for <linux-sparse@vger.kernel.org>; Sat, 11 Jul 2009 17:47:34 +0100 (BST)
Content-class: urn:content-classes:message
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello,

I'm interested in detecting endian mismatches in C code. The bitwise
facility in sparse seems ideal, however I ran into an interesting
example yesterday which sparse did not detect. I'm using sparse-0.4.1.

1. Specifically data was copied from a buffer in BE format to a buffer
in LE format using memcpy(). Using memcpy is kind of implying that the
programmer believes the types of the source and destination buffers are
compatible, so it would be nice if sparse could issue a warning when
they are not.

Here is a trivial test case.

#include "something-to-give-me-bitwise-types.h"

extern __le32* pLEdata;
extern __be32* pBEdata;

void copyBuffer(size_t length) {
	memcpy(pLEdata,pBEdata,length);
}

I would like to get a warning on line 7 (memcpy) because the types of
src and dst are different. 
I've tried #define memcpy(d,s,l) (*(d)=*(s)) which seems to work but
feels a bit ugly.

Is there a better way to do this?

2. Next I tried writing my own memcpy in the hope that I would then get
warnings in the normal way but got a warning implying that sparse knows
about memcpy 

warning: conflicting types for built-in function "memcpy"
foo.c: In function "memcpy":

3. So finally I tried writing a replacement my_memcpy whereupon I
discovered that apparently assigning a bitwise pointer to a void pointer
eliminates the bitwise-ness i.e. (append to the previous test case)

static void my_memcpy(void* dst, void* src, size_t len) {
 char* d = (char*)dst;
 char* s = (char*)src;

 while( len-- > 0 ) *(d++) = *(s++);
}

void copyBuffer_2(size_t length) {
 my_memcpy(pLEdata, pBEdata, length);
}

results in no warnings about passing a __le32* or __be32* to
my_memcpy(). You do get warnings if, for example, dst is an int*. I
suppose I can see that because you can't dereference a void* it doesn't
matter what it's pointing to, but on the other hand it's quite common to
throw void* around and cast it to what you actually want later on. Not
good practice, but all the more reason for sparse to complain :-)

Is this treatment of void* expected behaviour?

I'm new to sparse, and I apologise if these turn out to be dumb
questions. I did read the various bits of documentation and searched
this list first.

Thanks
Robert
-- 
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
