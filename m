From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/5] Fix an __attribute__() parsing error
Date: Thu, 24 May 2007 18:07:25 +0100
Message-ID: <4655C64D.4000704@ramsay1.demon.co.uk>
References: <46533263.3010108@ramsay1.demon.co.uk> <465370C2.3010801@freedesktop.org> <46537A0B.1020302@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:4240 "EHLO
	anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751107AbXEXROe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 13:14:34 -0400
In-Reply-To: <46537A0B.1020302@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: Josh Triplett <josh@freedesktop.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Michael Stefaniuc wrote:
> Josh Triplett wrote:
>> Ramsay Jones wrote:

>> Applied.  I think you just made a Wine developer very happy.  Michael, this
>> patch fixes the test case you provided for Wine; I applied your patch for the
>> new test case.
> Cool, thanks. Was just running a Wine build with cgcc when I have seen
> this so i've stopped it and run it again with the latest git checkout.
> And indeed it looks definitely better; the "error: too many errors"
> count went down from 1459 to 7.
> 
>> Thanks, Ramsay!
> Thanks indeed.

My pleasure; glad to be of help.

All the Best,

Ramsay Jones
