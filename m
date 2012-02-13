From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: sparse-llvm: pseudo_to_value: Assertion `sym->ident == ((void *)0)'
 failed
Date: Mon, 13 Feb 2012 18:17:39 +1100
Message-ID: <1329117459.2534.11.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:35910 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab2BMHRm (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 13 Feb 2012 02:17:42 -0500
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q1D7Hdog021286
	for <linux-sparse@vger.kernel.org>; Mon, 13 Feb 2012 01:17:40 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi folks !

Haven't had a chance to investigate further today (and probably won't)
so I'm shooting this here just in case ;-)

I was tracking down what looks like an LLVM bug with sign extension from
1-bit integers while playing with llvmpipe (gallium llvm backend) and
out of curiosity decided to look at what sparse generated when
sign-extending a bool :-)

So I added to my earlier hello.c some statements to that effect, and
trying to compile it results in:

sparse-llvm.c:311: pseudo_to_value: Assertion `sym->ident == ((void *)0)' failed.

The new hello.c is:

#include <stdio.h>
#include <stdbool.h>

int main(void)
{
        int i;
        double f1,f2;
        bool eq;

        printf("Hello World !\n");

        for (i = 0; i < 10; i ++)
                printf("I can count to %d\n", i);

        printf("f1=");
        scanf("%f",&f1);
        printf("f2=");
        scanf("%f",&f2);

        eq = f1 == f2;

        printf("f1==f2: %d\n", (int)eq);
        return 0;
}

Cheers,
Ben.


