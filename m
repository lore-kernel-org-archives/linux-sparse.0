From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Multiple translation unit regression
Date: Fri, 10 Jul 2009 21:53:58 +0100
Message-ID: <4A57AA66.4080305@ramsay1.demon.co.uk>
References: <4A5131F4.7070007@ramsay1.demon.co.uk>	 <70318cbf0907060232j7067f7fcra857b71ebdf62348@mail.gmail.com>	 <70318cbf0907062327u51a4253fub2c0f1b2f64c1a@mail.gmail.com>	 <4A54F452.8030601@ramsay1.demon.co.uk> <70318cbf0907081315w1e066a1fiac24b1b58ef146bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020709020201060304050702"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:61835 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752052AbZGJU4J (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 10 Jul 2009 16:56:09 -0400
In-Reply-To: <70318cbf0907081315w1e066a1fiac24b1b58ef146bb@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020709020201060304050702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Christopher Li wrote:
> On Wed, Jul 8, 2009 at 12:32 PM, Ramsay Jones<ramsay@ramsay1.demon.co.uk> wrote:
>> Unfortunately, the problem persists on Linux and I don't have time
>> tonight to try and debug it; I will look into it further, hopefully
>> tomorrow evening.
> 
> If you can give me a small test case on Linux that will be great.
> I can pick it up from there.
> 

[sorry for the late reply; something came up!]

I forgot to mention that, on Linux, enabling optimization is required to
trip this, since the extern inline function definitions are #ifdef'ed out
otherwise. That does not affect the following test case, however.

I've added to the previous test.c file (Note that the declaration of
g() does not include __inline__):

$ cat -n test.c
     1	
     2	extern __inline__ int f(int);
     3	
     4	extern __inline__ int
     5	f(int x)
     6	{
     7		return x;
     8	}
     9	
    10	
    11	extern int g(int);
    12	
    13	extern __inline__ int
    14	g(int x)
    15	{
    16		return x;
    17	}
    18	
$ ./sparse test.c
$ ./sparse test.c test.c
test.c:14:1: warning: multiple definitions for function 'g'
test.c:14:1:  the previous one is here
$ cp test.c test-again.c
$ ./sparse test.c test-again.c
test-again.c:14:1: warning: multiple definitions for function 'g'
test.c:14:1:  the previous one is here
$ 

Actually, the following may be closer to the situation on Linux:

$ cat -n test.c
     1	
     2	extern __inline__ int f(int);
     3	
     4	extern __inline__ int
     5	f(int x)
     6	{
     7		return x;
     8	}
     9	
    10	
    11	extern int g(int);
    12	
    13	#ifdef __OPTIMIZE__
    14	extern __inline__ int
    15	g(int x)
    16	{
    17		return x;
    18	}
    19	#endif
    20	
$ ./sparse test.c test.c
$ ./sparse -O2 test.c test.c
test.c:15:1: warning: multiple definitions for function 'g'
test.c:15:1:  the previous one is here


HTH

ATB
Ramsay Jones


--------------020709020201060304050702
Content-Type: text/plain;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.c"


extern __inline__ int f(int);

extern __inline__ int
f(int x)
{
	return x;
}


extern int g(int);

extern __inline__ int
g(int x)
{
	return x;
}


--------------020709020201060304050702--

