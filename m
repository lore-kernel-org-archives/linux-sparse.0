From: Pavel Roskin <proski@gnu.org>
Subject: Structures from -include are "weak"
Date: Sat, 07 Jul 2007 23:32:50 -0400
Message-ID: <1183865570.12651.18.camel@gx>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:23549 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbXGHDpd (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 7 Jul 2007 23:45:33 -0400
Received: from [192.168.1.100] (c-71-230-131-166.hsd1.pa.comcast.net [71.230.131.166])
	by relay.cesmail.net (Postfix) with ESMTP id 905A8618FE1
	for <linux-sparse@vger.kernel.org>; Sat,  7 Jul 2007 23:35:51 -0400 (EDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

I'm trying to use sparse on standalone kernel drivers that use -include
to include compatibility code for slightly older kernels, so that it's
possible to have exactly the same driver sources in the kernel and in
the standalone project.

Support for multiple -include switches has been very helpful, and things
have been working fine for some time, but now I'm seeing massive error
messages about dereferencing members of incomplete structures.

I've been able to reduce the problem to the following test case.

test.h:

struct st {
        int len;
};

test.c:

struct st;
int test(struct st *s);
int test(struct st *s)
{
        return s->len;
}

Commands to run:

$ sparse -include test.h test.c
test.c:5:10: error: using member 'len' in incomplete struct st
$ gcc -c -include test.h test.c
$

It looks like the definition of struct st is sort of "weak" when it's
read from the header included on the command line, so that the forward
declaration from test.c removes the original definition.

It's also possible to define struct st to something else, and sparse
won't warn about it.  But omitting "struct st;" fixes the error, so the
original definition is known to sparse.

-- 
Regards,
Pavel Roskin
