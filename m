From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/5] Sparse on Cygwin (and git).
Date: Thu, 24 May 2007 18:11:06 +0100
Message-ID: <4655C72A.3010106@ramsay1.demon.co.uk>
References: <46532ECD.2020502@ramsay1.demon.co.uk> <4653806B.1000901@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:4297 "EHLO
	anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750929AbXEXROq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 13:14:46 -0400
In-Reply-To: <4653806B.1000901@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Josh Triplett wrote:
> Ramsay Jones wrote:
>> Since git uses sparse in it's "check" make target,
> 
> Cool; I didn't know that. :)
heh, I don't know how often git developers "make check" ;-)

[...]
>> Unfortunately, at present,
>> I am using cygwin on win32 until I get around to installing Linux. ;-)
> 
> Fortunately, that resulted in some excellent patches. :)
> 
Apart from the whitespace breakage!

> [...]
>> 0001-Fix-an-__sentinel__-attribute-directive-ignored.patch
>> 0002-Fix-some-enum-value-...-not-handled-in-switch-wa.patch
>> 0003-Add-more-support-for-WIN32-attribute-names.patch
>> 0004-Fix-an-__attribute__-parsing-error.patch
>> 0005-Add-cygwin-support-to-cgcc.patch
>>
>> which was built on top of: 0.3-15-gb5bd30f
> 
> Looks like a good set of patches.  However, only patches 3 and 4 seem to have
> hit the list.
> 
Patch 2 was bounced by the vger spam blocker (because of the 3 uppercase x chars).

ATB,

Ramsay Jones
