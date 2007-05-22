From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: [PATCH 4/5] Fix an __attribute__() parsing error
Date: Wed, 23 May 2007 01:17:31 +0200
Message-ID: <46537A0B.1020302@redhat.com>
References: <46533263.3010108@ramsay1.demon.co.uk> <465370C2.3010801@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:43550 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756938AbXEVXRg (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 19:17:36 -0400
In-Reply-To: <465370C2.3010801@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Josh Triplett wrote:
> Ramsay Jones wrote:
>> When updating this patch from the 0.3 version, I made the (new) third parameter
>> KW_ATTRIBUTE only, rather than (KW_ATTRIBUTE | KW_ASM), since it did not seem
>> correct to allow an asm there; is that correct?
> 
> Correct; I don't think you can have an asm there.
> 
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
Cool, thanks. Was just running a Wine build with cgcc when I have seen
this so i've stopped it and run it again with the latest git checkout.
And indeed it looks definitely better; the "error: too many errors"
count went down from 1459 to 7.

> Thanks, Ramsay!
Thanks indeed.

bye
	michael
-- 
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart
