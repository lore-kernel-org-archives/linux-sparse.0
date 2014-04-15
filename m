From: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: Re: [PATCH] sparse{i,c}: use LLVM_CONFIG to find llc and lli
Date: Tue, 15 Apr 2014 15:53:30 -0700
Message-ID: <534DB86A.5090506@linux.vnet.ibm.com>
References: <1397591489-17411-1-git-send-email-cody@linux.vnet.ibm.com> <CANeU7Q=Vma64-WO8yCHueU71EewOMCDUrCDmB8iuQ4XaagS8aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:54976 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733AbaDOWxi (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Apr 2014 18:53:38 -0400
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <cody@linux.vnet.ibm.com>;
	Tue, 15 Apr 2014 18:53:36 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 6E3556E801C
	for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 18:53:28 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3FMrY8U39125112
	for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 22:53:34 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3FMrVrB031702
	for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 18:53:31 -0400
In-Reply-To: <CANeU7Q=Vma64-WO8yCHueU71EewOMCDUrCDmB8iuQ4XaagS8aw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 04/15/2014 03:28 PM, Christopher Li wrote:
> On Tue, Apr 15, 2014 at 12:51 PM, Cody P Schafer
> <cody@linux.vnet.ibm.com> wrote:
>> Some systems have multiple llvm versions installed, and have prefixed
>> executables ("<exec>-<version>"). While we could require the user to
>> specify a variable for each executable (LLC, LLI), using llvm-config
>> --bindir to locate them and allowing them to override using LLVM_CONFIG
>> makes much less work.
>
> How about this minor incremental patch? It will use the default variable
> to make the change smaller.
>

Yep, should have remembered that I could just use a default value for 
the variable. Looks good.

