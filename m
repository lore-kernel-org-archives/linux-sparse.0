From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/5] Fix an __attribute__() parsing error
Date: Thu, 24 May 2007 16:27:32 +0100
Message-ID: <4655AEE4.5070808@ramsay1.demon.co.uk>
References: <46533263.3010108@ramsay1.demon.co.uk> <465370C2.3010801@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:4209 "EHLO
	anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752013AbXEXRO2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 13:14:28 -0400
In-Reply-To: <465370C2.3010801@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Michael Stefaniuc <mstefani@redhat.com>

Josh Triplett wrote:
> Ramsay Jones wrote:
>> When updating this patch from the 0.3 version, I made the (new) third parameter
>> KW_ATTRIBUTE only, rather than (KW_ATTRIBUTE | KW_ASM), since it did not seem
>> correct to allow an asm there; is that correct?
> 
> Correct; I don't think you can have an asm there.
> 
OK, good.

>> The test case for this was abstracted from an example in the "expat.h" header file.
>>
>> $cat ape.c
>>
>> typedef void (__attribute__((__cdecl__)) *FP)(void *u, const char *n);
>>
>> void set_FP(void *cb, FP f);
> 
> Applied.  I think you just made a Wine developer very happy.  Michael, this
> patch fixes the test case you provided for Wine; I applied your patch for the
> new test case.
> 
> Thanks, Ramsay!
> 

My pleasure.

ATB,
Ramsay Jones
