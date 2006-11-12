From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sparse as a compiler front-end
Date: Sat, 11 Nov 2006 22:22:41 -0500
Message-ID: <45569381.9000109@garzik.org>
References: <45564680.8090806@garzik.org> <20061111235002.GA15184@humbolt.us.dell.com> <45567CC5.4030806@garzik.org> <20061112030453.GA20415@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:31421 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1753958AbWKLDWn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 Nov 2006 22:22:43 -0500
In-Reply-To: <20061112030453.GA20415@humbolt.us.dell.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

Matt Domsch wrote:
> On Sat, Nov 11, 2006 at 08:45:41PM -0500, Jeff Garzik wrote:
>> Matt Domsch wrote:
>>> On Sat, Nov 11, 2006 at 04:54:08PM -0500, Jeff Garzik wrote:
>>>> I see that sparse made it into Fedora Extras, so that 'yum install' 
>>>> automatically pulls it down for me.  Yay!  Thanks, Matt.
>>>>
>>>> Can libsparse.a and necessary includes be packaged as well?
>>> .a or .so?  The .so just got dropped from the standard sparse 'make
>> Doesn't matter to me...  Something is better than nothing.  With 
>> sparse's license, .a is no big deal.
> 
> Fedora Extras strongly discourages shipping and using .a if only to
> ensure that any security issue uncovered can be addressed without
> always rebuilding all downstream dependent apps.  Not too likely a
> problem with a tool like sparse, but always a concern.
> 
> The .so would need to start being versioned, and care paid to bump the
> version as the ABIs change.

Or alteratively we could recognize that sparse is a bit of an unusual 
lib.  With the library likely to be changing rapidly, caring about ABIs 
at this early stage probably isn't in anybody's best interests.

	Jeff
