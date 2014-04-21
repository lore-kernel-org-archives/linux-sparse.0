From: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: Re: [PATCH] parse: support c99 [static ...] in abstract array declarators
Date: Mon, 21 Apr 2014 09:43:12 -0700
Message-ID: <53554AA0.2070903@linux.vnet.ibm.com>
References: <1397603337-28016-1-git-send-email-cody@linux.vnet.ibm.com> <20140417001234.GA18426@leaf>	<534F4F7F.5020506@linux.vnet.ibm.com> <20140417050914.GA21150@leaf> <CANeU7Q=qfD=fpP1k1gHpUxek4ZUuau3drCDncYr5eE18Xiq4Zw@mail.gmail.com> <CANeU7Qn-CV1Raae1-E03tJCDidzV8tshwjE8M+JCh3r70zXokw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:39259 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbaDUQnU (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Apr 2014 12:43:20 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <cody@linux.vnet.ibm.com>;
	Mon, 21 Apr 2014 12:43:19 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9736338C801C
	for <linux-sparse@vger.kernel.org>; Mon, 21 Apr 2014 12:43:16 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3LGhGqs46858374
	for <linux-sparse@vger.kernel.org>; Mon, 21 Apr 2014 16:43:16 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3LGhFTI013316
	for <linux-sparse@vger.kernel.org>; Mon, 21 Apr 2014 12:43:16 -0400
In-Reply-To: <CANeU7Qn-CV1Raae1-E03tJCDidzV8tshwjE8M+JCh3r70zXokw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 04/17/2014 10:52 PM, Christopher Li wrote:
> On Wed, Apr 16, 2014 at 11:50 PM, Christopher Li <sparse@chrisli.org> wrote:
>
>> Here is a purpose patch with limited test. I expand the test to cover
>> more static test case.
>>
>> Cody, does this patch work for you?
>
> I apply the patch and push it out.
>
> Please let me know if it breaks any thing.
>

Looks fine to me Chris, thanks for putting this together.

