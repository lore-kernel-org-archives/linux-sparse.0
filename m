From: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: Re: [PATCH] parse: support c99 [static ...] in abstract array declarators
Date: Wed, 16 Apr 2014 20:50:23 -0700
Message-ID: <534F4F7F.5020506@linux.vnet.ibm.com>
References: <1397603337-28016-1-git-send-email-cody@linux.vnet.ibm.com> <20140417001234.GA18426@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:32787 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756979AbaDQDu2 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 Apr 2014 23:50:28 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <cody@linux.vnet.ibm.com>;
	Wed, 16 Apr 2014 23:50:27 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4B51238C8023
	for <linux-sparse@vger.kernel.org>; Wed, 16 Apr 2014 23:50:25 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3H3oP7D10355162
	for <linux-sparse@vger.kernel.org>; Thu, 17 Apr 2014 03:50:25 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3H3oOmt023849
	for <linux-sparse@vger.kernel.org>; Wed, 16 Apr 2014 23:50:25 -0400
In-Reply-To: <20140417001234.GA18426@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org

On 04/16/2014 05:12 PM, Josh Triplett wrote:
> On Tue, Apr 15, 2014 at 04:08:57PM -0700, Cody P Schafer wrote:
>> Makes sparse a little more accepting than the standard: we accept any
>> number of ["static", "restrict"] repeated in any order, while the n1570
>> specifies (in 6.7.6.2.3) that either type-qualifiers (ie: "restrict")
>> come first and are followed by "static" or the opposite ("static" then
>> type-qualifiers).
>>
>> Also add a test.
>>
>> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
>
> What's the rationale for this?  Why should sparse accept more than the
> standard allows?  What real-world code do you have that requires this?
>
> And would it be worth adding a warning for this non-standards-compliant
> code, even if that warning isn't on by default?

I could have sparse be just as strict as the standard, it just was just 
(much) simpler to make it liberal in what it accepts. If you're fine 
with some more verbose code, I'll put together something that is stricter.

